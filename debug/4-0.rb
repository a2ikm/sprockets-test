module Sprockets
  module Transformers
    def expand_transform_accepts_with_debug(parsed_accepts)
      parsed_accepts = parsed_accepts.to_h

      root_accepts = {}
      parsed_accepts.each do |type, q|
        mod_q = q * 0.8
        root_type = find_root_accept(type)
        root_accepts[root_type] = root_accepts.key?(root_type) ? [mod_q, root_accepts[root_type]].max : mod_q
      end

      accepts = {}
      root_accepts.each do |type, q|
        accepts[type] = q
        config[:inverted_transformers][type].each do |subtype|
          accepts[subtype] = parsed_accepts[subtype] || q
        end
      end
      accepts.sort_by { |(type, q)| -q }
    end

    alias expand_transform_accepts_without_debug expand_transform_accepts
    alias expand_transform_accepts expand_transform_accepts_with_debug

    def find_root_accept(type)
      config[:transformers][type].keys.find do |dst|
        !config[:transformers].key?(dst) || config[:transformers][dst].empty?
      end
    end
  end
end
