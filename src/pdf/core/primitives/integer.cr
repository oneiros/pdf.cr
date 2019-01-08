require "./object"

module PDF
  module Core
    module Primitives
      class Integer < Object
        def initialize(@value : Int32)
        end

        def to_s(indent : Int32) : String
          @value.to_s
        end
      end
    end
  end
end
