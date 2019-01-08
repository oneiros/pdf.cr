require "../spec_helper.cr"

class Testfile < PDF::Core::File
  def initialize
    super
    page = PDF::Core::Page.new
    text_content = <<-TEXT
        BT
          /F1 18 Tf
          0 0 Td
          (Hello World) Tj
        ET
    TEXT
    content_stream = PDF::Core::Primitives::Stream.new(text_content)
    add_object(content_stream)
    page.contents << content_stream.reference
    graphics = PDF::Core::Graphics.new
    graphics.path(0, 0)
    graphics.line(100, 100)
    graphics.close_and_stroke_path
    graphics.circle(50, 50, 10)
    graphics.close_and_stroke_path

    add_object(graphics)
    page.contents << graphics.reference
    add_object(page)
    @pages_root.add_page(page)
  end
end

describe PDF::Core::File do
  it "can write a simple PDF file" do
    file = Testfile.new
    file.write("/tmp/minimal.pdf")
  end
end
