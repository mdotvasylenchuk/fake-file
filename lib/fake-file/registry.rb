# frozen_string_literal: true

module FakeFile
  class Registry
    class UnsupportedFormatError < StandardError; end

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
        format.to_s.downcase.to_sym
      end

      def generators
        @generators ||= {}
      end
    end
  end
end
