require "pry-byebug"

if Sprockets::VERSION.start_with?("4.0")
  require "./init_4-0"
else
  require "./init_3-7"
end
