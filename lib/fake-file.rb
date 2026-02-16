# frozen_string_literal: true

require_relative "fake-file/version"
require_relative "fake-file/registry"
require_relative "fake-file/generators/pdf_generator"
require_relative "fake-file/generators/docx_generator"
require_relative "fake-file/generators/xlsx_generator"
require "rack/test/uploaded_file"

module FakeFile
  MIME_TYPES = {
    pdf: "application/pdf",
    docx: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    xlsx: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  }.freeze

  class << self
    def generate(format, options = {})
      Registry.fetch(format).generate(options)
    end

    def upload(format, options = {})
      generated_file = generate(format, options)
      file_extension = File.extname(generated_file.path)
      filename = "#{format}#{file_extension}"

      Rack::Test::UploadedFile.new(
        generated_file.path,
        MIME_TYPES.fetch(format.to_sym),
        true,
        original_filename: filename
      )
    end

    def pdf(options = {})
      generate(:pdf, options)
    end

    def docx(options = {})
      generate(:docx, options)
    end

    def xlsx(options = {})
      generate(:xlsx, options)
    end
  end

  Registry.register(:pdf, Generators::PdfGenerator.new)
  Registry.register(:docx, Generators::DocxGenerator.new)
  Registry.register(:xlsx, Generators::XlsxGenerator.new)
end
