module PDF
  module DSL
    class Text < PageObject
      def initialize(@text : String, @at : PDF::DSL::Dimensions)
      end

      def to_pdf_object : PDF::Core::Primitives::Object
        PDF::Core::Primitives::Stream.new(
          <<-TEXT
          BT
            /F1 12 Tf
            #{@at[0]} #{@at[1]} Td
            (#{@text}) Tj
          ET
          TEXT
        )
      end
    end
  end
end
