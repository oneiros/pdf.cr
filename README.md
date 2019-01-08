# pdf.cr

A crystal PDF library in _very_ early stages of development.

The immediate goal is to generate PDF files, possibly similar to the ruby gem
`prawn`.

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  pdf:
    github: oneiros/pdf.cr
```
2. Run `shards install`

## Usage

```crystal
require "pdf"
```

### Document Creation DSL

```crystal
include PDF::DSL

my_pdf = document do
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

my_pdf.write_to_file("/tmp/my.pdf")
```

### Low-level primitives

The classes in `src/pdf/core/` provide a very low-level abstraction, trying to
preserve naming used in the PDF spec.

`src/pdf/core/primitives/` holds classes that represent "objects", the basic
building blocks of a PDF file.

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/oneiros/pdf.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [David Roetzel](https://github.com/oneiros) - creator and maintainer
