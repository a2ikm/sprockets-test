def build(version)
  sh "BUNDLE_GEMFILE=gemfiles/#{version}/Gemfile bundle exec sprockets --include assets/javascripts --output builds/#{version} assets/javascripts/application.coffee assets/javascripts/hello.jst.eco"
end

namespace :build do
  task :v37 do
    build("3-7")
  end
  task :v40 do
    build("4-0")
  end
end
