def build(version)
  sh "BUNDLE_GEMFILE=gemfiles/#{version}/Gemfile bundle exec sprockets --include assets/javascripts --output builds/#{version} assets/javascripts/application.coffee assets/javascripts/hello.jst.eco"
end

task :default => :all
task :all => [:v37, :v40]
task :v37 do
  build("3-7")
end

task :v40 do
  build("4-0")
end

task :clean do
  sh "rm -rf builds"
  sh "git checkout builds"
end
