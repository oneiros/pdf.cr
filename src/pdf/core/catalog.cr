module PDF
  module Core
    class Catalog < Primitives::Dictionary
      def initialize(pages : Pages)
        super(
          type: :catalog,
          pages: pages.reference
        )
      end
    end
  end
end
