class PDF::Core::Pages < PDF::Core::Primitives::Dictionary
  @pages = [] of Page

  def initialize
    super(
      type: :pages,
      media_box: Primitives::Array.new([0, 0, 300, 144].map { |i| Primitives::Integer.new(i) })
    )
  end

  def add_page(page : Page)
    @pages << page
    page.parent = self
  end

  def to_s(indent : Int32) : String
    self[Primitives::Name.new("Kids")] = Primitives::Array.new(@pages.map(&.reference))
    self[Primitives::Name.new("Count")] = Primitives::Integer.new(@pages.size)
    super
  end
end
