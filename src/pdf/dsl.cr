module PDF
  module DSL
    alias Dimensions = Tuple(Int32 | Float64, Int32 | Float64)

    enum Orientation
      Portrait
      Landscape
    end

    A4     = {595.28, 841.89}
    A5     = {419.53, 595.28}
    LETTER = {612.00, 792.00}

    def document
      doc = Document.new
      with doc yield
      doc
    end
  end
end
