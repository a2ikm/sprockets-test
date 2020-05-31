module Sprockets
  module Transformers
    def expand_transform_accepts_with_debug(parsed_accepts)
      expand_transform_accepts_without_debug(parsed_accepts) + [
        ["text/eco", 0.8],
        ["text/eco+ruby", 0.8],
        ["application/javascript+function", 0.8],
        ["application/javascript", 0.8],
      ]
    end

    alias expand_transform_accepts_without_debug expand_transform_accepts
    alias expand_transform_accepts expand_transform_accepts_with_debug
  end
end
