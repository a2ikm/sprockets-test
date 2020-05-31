require "fileutils"

def build(version, name, *paths)
  FileUtils.mkdir_p("builds/#{name}/#{version}")

  args = %W(
    BUNDLE_GEMFILE=gemfiles/#{version}/Gemfile
    bundle exec sprockets
      --include assets/javascripts
      --output builds/#{name}/#{version}
  )

  if version == "4-0"
    args += %W(--cache caches/#{name}/#{version})
    FileUtils.mkdir_p("caches/#{name}/#{version}")
  end

  args += paths.map { |path| File.join("assets/javascripts", path) }

  sh(args.join(" "))
end

task :default => %w(
  clean
  v37:single:js
  v37:single:coffee
  v37:view:js
  v37:view:coffee
  v40:single:js
  v40:single:coffee
  v40:view:js
  v40:view:coffee
)

namespace :v37 do
  namespace :single do
    task :js do
      build("3-7", "single_js", "single.js")
    end
    task :coffee do
      build("3-7", "single_coffee", "single.coffee")
    end
  end
  namespace :view do
    task :js do
      build("3-7", "view_js", "view.js", "view_template.jst.eco")
    end
    task :coffee do
      build("3-7", "view_coffee", "view.coffee", "view_template.jst.eco")
    end
  end
end

namespace :v40 do
  namespace :single do
    task :js do
      build("4-0", "single_js", "single.js")
    end
    task :coffee do
      build("4-0", "single_coffee", "single.coffee")
    end
  end
  namespace :view do
    task :js do
      build("4-0", "view_js", "view.js", "view_template.jst.eco")
    end
    task :coffee do
      build("4-0", "view_coffee", "view.coffee", "view_template.jst.eco")
    end
  end
end

task :clean do
  if File.exist?("builds")
    sh "rm -rf builds"
    sh "git checkout builds"
  end
end
