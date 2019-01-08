class PDF::Core::Pages < PDF::Core::Primitives::Dictionary
  @pages = [] of Page

  def initialize(width : Float64, height : Float64)
    media_box = [0.0, 0.0, width, height]
    super(
      type: :pages,
      media_box: Primitives::Array.new(media_box.map { |f| Primitives::Real.new(f) })
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
