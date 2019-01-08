module PDF
  module DSL
    class Page
      @page_objects = [] of PageObject
      @pdf_objects = [] of PDF::Core::Primitives::Object

      def text(text : String, at : PDF::DSL::Dimensions)
        @page_objects << Text.new(text, at)
      end

      def line(from : PDF::DSL::Dimensions, to : PDF::DSL::Dimensions)
        @page_objects << Line.new(from, to)
      end

      def circle(at : PDF::DSL::Dimensions, radius : Int32 | Float64)
        @page_objects << Circle.new(at, radius)
      end

      def pdf_objects
        @page_objects.map(&.to_pdf_object).each { |o| @pdf_objects << o }
        @pdf_objects
      end

      def to_pdf_page
        pdf_page = PDF::Core::Page.new
        @pdf_objects.each { |o| pdf_page.contents << o.reference }
        pdf_page
      end
    end
  end
end
