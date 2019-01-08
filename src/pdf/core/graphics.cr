module PDF
  module Core
    class Graphics < Primitives::Stream
      @instructions = [] of String

      def initialize
        super("")
      end

      def path(x : Int32, y : Int32)
        @instructions << "#{x} #{y} m\n"
      end

      def line(x : Int32, y : Int32)
        @instructions << "#{x} #{y} l\n"
      end

      def bezier(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64, x3 : Int32, y3 : Int32)
        @instructions << "#{x1} #{y1} #{x2} #{y2} #{x3} #{y3} c\n"
      end

      def circle(x : Int32, y : Int32, radius : Int32)
        magic = radius * 0.551784
        radius_f = radius.to_f64
        path(x - radius, y)
        bezier((x - radius).to_f64, y + magic, x - magic, y + radius_f, x, y + radius)
        bezier(x + magic, y + radius_f, x + radius_f, y + magic, x + radius, y)
        bezier(x + radius_f, y - magic, x + magic, y - radius_f, x, y - radius)
        bezier(x - magic, y - radius_f, x - radius_f, y - magic, x - radius, y)
      end

      def close_path
        @instructions << "h\n"
      end

      def rectangle(x : Int32, y : Int32, width : Int32, height : Int32)
        @instructions << "#{x} #{y} #{width} #{height} re\n"
      end

      def stroke_path
        @instructions << "S\n"
      end

      def close_and_stroke_path
        @instructions << "s\n"
      end

      def fill_path
        @instructions << "f\n"
      end

      def to_s(indent : Int32) : String
        @content = @instructions.join
        super
      end
    end
  end
end
