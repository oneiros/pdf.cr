module PDF
  module Core
    module Primitives
      abstract class Object
        property number : Int32?
        property generation : Int32 = 0
        property byte_offset : Int64?

        def indirect? : Bool
          !number.nil?
        end

        def reference : Reference
          raise "not an indirect object" unless indirect?
          Reference.new(self)
        end

        def xref : String
          raise "not an indirect object" unless indirect?
          sprintf("%010d %05d n \n", byte_offset, generation)
        end

        def to_s : String
          if indirect?
            String.build do |str|
              str << "#{number} #{generation} obj\n"
              str << "  "
              str << to_s(indent: 2)
              str << "\n"
              str << "endobj\n"
            end
          else
            to_s(indent: 0)
          end
        end

        abstract def to_s(indent : Int32) : String
      end
    end
  end
end
