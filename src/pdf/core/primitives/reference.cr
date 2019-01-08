module PDF
  module Core
    module Primitives
      class Reference < Object
        def initialize(@object : Object)
        end

        def to_s(indent : Int32) : String
          "#{@object.number} #{@object.generation} R"
        end
      end
    end
  end
end
