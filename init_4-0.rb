module Sprockets
  class Manifest
    def compile(*args)
      unless environment
        raise Error, "manifest requires environment for compilation"
      end

      filenames            = []
      concurrent_exporters = []

      assets_to_export = Concurrent::Array.new
      find(*args) do |asset|
        assets_to_export << asset
      end

      p args
      p assets_to_export
      assets_to_export.each do |asset|
        mtime = Time.now.iso8601
        files[asset.digest_path] = {
          'logical_path' => asset.logical_path,
          'mtime'        => mtime,
          'size'         => asset.bytesize,
          'digest'       => asset.hexdigest,

          # Deprecated: Remove beta integrity attribute in next release.
          # Callers should DigestUtils.hexdigest_integrity_uri to compute the
          # digest themselves.
          'integrity'    => DigestUtils.hexdigest_integrity_uri(asset.hexdigest)
        }
        assets[asset.logical_path] = asset.digest_path

        filenames << asset.filename

        promise      = nil
        exporters_for_asset(asset) do |exporter|
          next if exporter.skip?(logger)

          if promise.nil?
            promise = Concurrent::Promise.new(executor: executor) { exporter.call }
            concurrent_exporters << promise.execute
          else
            concurrent_exporters << promise.then { exporter.call }
          end
        end
      end

      # make sure all exporters have finished before returning the main thread
      concurrent_exporters.each(&:wait!)
      save

      p filenames
      filenames
    end
  end
end
