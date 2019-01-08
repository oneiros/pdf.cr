module PDF
  module DSL
    abstract class PageObject
      abstract def to_pdf_object : PDF::Core::Primitives::Object
    end
  end
end
