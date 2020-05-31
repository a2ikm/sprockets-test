require "pry-byebug"

if Sprockets::VERSION.start_with?("4.0")
  require "./debug/4-0"
else
  require "./debug/3-7"
end
