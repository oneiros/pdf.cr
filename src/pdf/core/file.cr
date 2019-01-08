class PDF::Core::File
  @pages_root = Pages.new
  @objects = {} of Int32 => Primitives::Object

  def initialize
    @objects[1] = @pages_root
    @pages_root.number = 2
    @document_catalog = Catalog.new(@pages_root)
    @objects[0] = @document_catalog
    @document_catalog.number = 1
    @last_object_number = 2
    @xref_offset = 0_i64
  end

  def add_object(object : Primitives::Object)
    @last_object_number += 1
    object.number = @last_object_number
    @objects[@last_object_number] = object
  end

  def write(path : String)
    ::File.open(path, "wb") do |f|
      f.print header
      @objects.keys.sort.each do |key|
        object = @objects[key]
        f.print("\n")
        f.flush
        object.byte_offset = f.pos
        f.print(object.to_s)
      end
      f.print("\n")
      f.flush
      @xref_offset = f.pos
      f.print xref_table
      f.print trailer
    end
  end

  private def header : String
    "%PDF-1.7\n%\x81\x82\x83\x84\n"
  end

  private def xref_table : String
    String.build do |str|
      str << "xref\n"
      str << "0000000000 65535 f \n"
      slices = [] of ::Array(Int32)
      current_range = [] of Int32
      numbers = @objects.keys.sort.dup
      @objects.keys.sort.each do |number|
        if current_range.empty? || current_range.last + 1 == number
          current_range << numbers.shift
        else
          slices << current_range.dup
          current_range.clear
          current_range << number
        end
      end
      slices << current_range if current_range.any?
      slices.each do |range|
        str << "#{range.first} #{range.size}\n"
        range.each do |number|
          str << @objects[number].xref
        end
      end
    end
  end

  private def trailer
    String.build do |str|
      str << "trailer\n  "
      str << Primitives::Dictionary.new(
        size: @objects.size,
        root: @document_catalog.reference
      ).to_s(2)
      str << "\nstartxref\n"
      str << "#{@xref_offset}\n"
      str << "%%EOF"
    end
  end
end
