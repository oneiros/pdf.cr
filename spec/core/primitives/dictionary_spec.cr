require "../../spec_helper"

module PDF
  module Core
    module Primitives
      describe Dictionary do
        describe "::new" do
          it "initializes with a hash" do
            dictionary = Dictionary.new({
              Name.new("Type") => Name.new("Test"),
              Name.new("Info") => Name.new("Other"),
            })
          end

          it "initializes with a NamedTuple" do
            dictionary = Dictionary.new(
              type: :test,
              info: :other
            )
          end

          it "initializes with a NamedTuple of mixed types" do
            dictionary = Dictionary.new(
              type: :test,
              size: 23
            )
          end

          it "initializes with a nested NamedTuple" do
            dictionary = Dictionary.new(
              type: :test,
              nestedDic: {
                info: :hi,
                size: 23,
              }
            )
          end
        end

        describe "#to_s" do
          it "formats a flat dictionary properly" do
            dictionary = Dictionary.new({
              Name.new("Type") => Name.new("Test"),
              Name.new("Info") => Name.new("Other"),
            })
            dictionary.to_s(0).should eq(<<-PDF
                                         << /Type /Test
                                            /Info /Other
                                            >>
                                         PDF
            )
          end

          it "formats a nested dictionary properly" do
            dictionary = Dictionary.new({
              Name.new("Type") => Name.new("Test"),
              Name.new("Info") => Dictionary.new({
                Name.new("Type") => Name.new("Nested"),
                Name.new("Info") => Name.new("Other"),
              }),
            })
            dictionary.to_s(0).should eq(<<-PDF
                                         << /Type /Test
                                            /Info << /Type /Nested
                                                     /Info /Other
                                                     >>
                                            >>
                                         PDF
            )
          end
        end
      end
    end
  end
end
