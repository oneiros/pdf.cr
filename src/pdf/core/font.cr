class PDF::Core::Font < PDF::Core::Primitives::Dictionary
  def initialize(name : String, sub_type : String, base_font : String)
    super(
      font: Primitives::Dictionary.new({
        Primitives::Name.new(name) => Primitives::Dictionary.new(
          type: :font,
          subtype: Primitives::Name.new(sub_type),
          base_font: Primitives::Name.new(base_font)
        ),
      })
    )
  end
end
