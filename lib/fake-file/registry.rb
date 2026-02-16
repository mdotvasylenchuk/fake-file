# frozen_string_literal: true

module FakeFile
  class Registry
    class UnsupportedFormatError < StandardError; end

    ALIASES = {
      doc: :docx,
      xls: :xlsx,
      xsl: :xlsx
    }.freeze

    class << self
      def register(format, generator)
        generators[normalize(format)] = generator
      end

      def fetch(format)
        generators.fetch(normalize(format)) do
          raise UnsupportedFormatError, "Unsupported format: #{format.inspect}"
        end
      end

      private

      def normalize(format)
        normalized = format.to_s.downcase.to_sym
        ALIASES.fetch(normalized, normalized)
      end

      def generators
        @generators ||= {}
      end
    end
  end
end
