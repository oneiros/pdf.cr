require "../../spec_helper"

describe PDF::Core::Primitives::Name do
  describe "#to_s" do
    it "returns a valid PDF Name" do
      name = PDF::Core::Primitives::Name.new("Type")
      name.to_s(0).should eq("/Type")
    end
  end
end
