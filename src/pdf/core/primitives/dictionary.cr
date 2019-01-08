require "./name"

module PDF
  module Core
    module Primitives
      class Dictionary < Object
        @dictionary = {} of Name => Object

        delegate :[], :[]=, each, to: @dictionary

        def initialize(hash : Hash(Name, Object))
          hash.each do |key, value|
            @dictionary[key] = value
          end
        end

        def initialize(**dictionary)
          dictionary.each do |key, value|
            @dictionary[Name.new(key)] = wrap(value)
          end
        end

        def to_s(indent : Int32) : String
          String.build do |str|
            str << "<< "
            @dictionary.each do |name, object|
              current_indent = (name == @dictionary.keys.first ? 0 : indent + 3)
              str << "#{" " * current_indent}#{name.to_s(0)} #{object.to_s(name.to_s(0).size + 4 + indent)}\n"
            end
            str << "#{" " * (indent + 3)}>>"
          end
        end

        private def wrap(value) : Object
          case value
          when Int32
            Integer.new(value)
          when NamedTuple
            Dictionary.new(**value)
          when Symbol
            Name.new(value)
          when Object
            value
          else
            raise ArgumentError.new("Do not know how to handle #{value.class}")
          end
        end
      end
    end
  end
end
