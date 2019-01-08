require "./object"

module PDF
  module Core
    module Primitives
      class Name < Object
        def initialize(@identifier : String)
        end

        def initialize(identifier : Symbol)
          @identifier = identifier.to_s.camelcase
        end

        def to_s(indent : Int32) : String
          "/#{@identifier}"
        end
      end
    end
  end
end
