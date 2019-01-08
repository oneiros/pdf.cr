class PDF::Core::Page < PDF::Core::Primitives::Dictionary
  getter contents : Array(Primitives::Reference)

  def initialize
    super(
      type: :page,
      resources: Font.new("F1", "Type1", "Times-Roman")
    )
    @contents = [] of Primitives::Reference
  end

  def parent=(pages : Pages)
    self[Primitives::Name.new("Parent")] = pages.reference
  end

  def to_s(indent : Int32) : String
    self[Primitives::Name.new("Contents")] = Primitives::Array.new(@contents)
    super
  end
end
