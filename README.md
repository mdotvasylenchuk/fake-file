# fake-file

[![Gem Version](https://badge.fury.io/rb/fake-file.svg)](https://rubygems.org/gems/fake-file)
[![CI](https://github.com/mdotvasylenchuk/fake-file/actions/workflows/main.yml/badge.svg)](https://github.com/mdotvasylenchuk/fake-file/actions/workflows/main.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`fake-file` is a Ruby gem for generating temporary fake files for tests.

It helps when you need to attach a file to a model (ActiveStorage, Shrine, CarrierWave, etc.) without storing fixture files in `spec/files`.

Currently supported formats:

- `pdf`
- `docx`
- `xlsx`

## Installation

Add to your app's Gemfile:

```ruby
gem "fake-file"
```

Then run:

```bash
bundle install
```

Or install manually:

```bash
gem install fake-file
```

## Quick Start

```ruby
require "fake-file"

pdf_file = FakeFile.pdf
docx_file = FakeFile.docx
xlsx_file = FakeFile.xlsx
```

Each method returns a `Tempfile` object ready to use in tests.

## API

### Facade methods

```ruby
FakeFile.pdf(options = {})
FakeFile.docx(options = {})
FakeFile.xlsx(options = {})
```

### Generic generator

```ruby
FakeFile.generate(:pdf)
FakeFile.generate(:docx)
FakeFile.generate(:xlsx)
```

### Rack::Test uploaded file helper

```ruby
FakeFile.upload(:pdf)
FakeFile.upload(:docx)
FakeFile.upload(:xlsx)
```

Returns `Rack::Test::UploadedFile`, so you can use it directly in request specs.

## Usage in tests

### ActiveStorage example

```ruby
it "attaches generated pdf" do
    file = FakeFile.pdf

    record.file.attach(
        io: file,
        filename: "sample.pdf",
        content_type: "application/pdf"
    )

    expect(record.file).to be_attached
end
```

### Verify MIME type

```ruby
require "marcel"

expect(Marcel::MimeType.for(FakeFile.docx))
    .to eq("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
```

### Request spec with Rack::Test

```ruby
post "/imports", params: { file: FakeFile.upload(:xlsx) }
```

## Adding a new format

1. Create a new generator class in `lib/fake-file/generators/`.
2. Inherit from `BaseGenerator` and implement `#generate`.
3. Register it in `lib/fake-file.rb`:

```ruby
Registry.register(:txt, Generators::TxtGenerator.new)
```

After that, it becomes available via:

```ruby
FakeFile.generate(:txt)
```

## Development

Install dependencies:

```bash
bundle install
```

Run specs:

```bash
ruby -S bundle exec rspec
```

Open console:

```bash
bin/console
```

## Contributing

Issues and pull requests are welcome:

- https://github.com/mdotvasylenchuk/fake-file

Please follow [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## License

The gem is distributed under the MIT license. See [LICENSE.txt](LICENSE.txt).
