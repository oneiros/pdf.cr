module PDF
  module Core
    module Primitives
      class Real < Object
        def initialize(@value : Float64)
        end

        def to_s(indent : Int32) : String
          @value.to_s
        end
      end
    end
  end
end
