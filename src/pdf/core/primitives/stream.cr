module PDF
  module Core
    module Primitives
      class Stream < Object
        def initialize(@content : String)
          @dictionary = Dictionary.new
        end

        def to_s(indent : Int32) : String
          raise "streams must be indirect objects" unless indirect?
          @dictionary[Name.new("Length")] = Integer.new(@content.bytesize)
          String.build do |str|
            str << @dictionary.to_s(0)
            str << "\nstream\n"
            str << @content
            str << "\nendstream"
          end
        end
      end
    end
  end
end
