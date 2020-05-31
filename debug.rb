require "pry-byebug"

if Sprockets::VERSION.start_with?("4.0")
  require "./debug_4-0"
else
  require "./debug_3-7"
end
