require "./page_object"

module PDF
  module DSL
    class Line < PageObject
      def initialize(@from : PDF::DSL::Dimensions, @to : PDF::DSL::Dimensions)
      end

      def to_pdf_object : PDF::Core::Primitives::Object
        result = PDF::Core::Graphics.new
        result.path(@from[0], @from[1])
        result.line(@to[0], @to[1])
        result.close_and_stroke_path
        result
      end
    end
  end
end
