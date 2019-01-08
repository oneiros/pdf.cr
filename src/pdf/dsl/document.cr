module PDF
  module DSL
    class Document
      @page_size = DSL::LETTER
      @page_orientation = Orientation::Portrait
      @pages = [] of Page

      def initialize
      end

      def page_size(new_size : Dimensions)
        @page_size = new_size
      end

      def page_orientation(new_orientation : Orientation)
        @page_orientation = new_orientation
      end

      def page
        new_page = Page.new
        with new_page yield
        @pages << new_page
      end

      def write_to_file(path : String)
        pdf_file = PDF::Core::File.new(*dimensions)
        @pages.each do |page|
          page.pdf_objects.each do |object|
            pdf_file.add_object(object)
          end
          pdf_file.add_page(page.to_pdf_page)
        end
        pdf_file.write(path)
      end

      private def dimensions : Tuple(Float64, Float64)
        base_dimensions =
          if @page_orientation == Orientation::Portrait
            @page_size
          else
            @page_size.reverse
          end
        {base_dimensions[0].to_f, base_dimensions[1].to_f}
      end
    end
  end
end
