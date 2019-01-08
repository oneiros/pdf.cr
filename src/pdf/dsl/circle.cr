require "./page_object"

module PDF
  module DSL
    class Circle < PageObject
      def initialize(@at : PDF::DSL::Dimensions, @radius : Int32 | Float64)
      end

      def to_pdf_object : PDF::Core::Primitives::Object
        result = PDF::Core::Graphics.new
        result.circle(@at[0], @at[1], @radius)
        result.close_and_stroke_path
        result
      end
    end
  end
end
