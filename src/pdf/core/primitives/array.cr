require "./object"

module PDF
  module Core
    module Primitives
      class Array < Object
        @list = [] of Object

        delegate :<<, to: @list

        def initialize
        end

        def initialize(list : ::Array(Object))
          list.each { |e| @list << e }
        end

        def to_s(indent : Int32) : String
          "[#{@list.map(&.to_s(0)).join(" ")}]"
        end
      end
    end
  end
end
