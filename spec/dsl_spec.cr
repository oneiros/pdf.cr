require "./spec_helper"

include PDF::DSL

describe PDF::DSL do
  it "is possible to construct a basic document" do
    subject = document do
      page_size A4
      page_orientation Orientation::Landscape

      page do
        text "Headline", at: {0, 10}
        line from: {0, 0}, to: {10, 10}
      end

      page do
        circle at: {100, 100}, radius: 20
      end
    end

    subject.write_to_file("/tmp/dsl.pdf")
  end
end
