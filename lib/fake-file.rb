# frozen_string_literal: true

require_relative "fake-file/version"
require_relative "fake-file/registry"
require_relative "fake-file/generators/pdf_generator"
require_relative "fake-file/generators/docx_generator"
require_relative "fake-file/generators/xlsx_generator"

module FakeFile
  class << self
    def generate(format, options = {})
      Registry.fetch(format).generate(options)
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

  class Document
    class << self
      def pdf(options = {})
        FakeFile.pdf(options)
      end

      def docx(options = {})
        FakeFile.docx(options)
      end

      def xlsx(options = {})
        FakeFile.xlsx(options)
      end
    end
  end

  Registry.register(:pdf, Generators::PdfGenerator.new)
  Registry.register(:docx, Generators::DocxGenerator.new)
  Registry.register(:xlsx, Generators::XlsxGenerator.new)
end
