# frozen_string_literal: true

require "securerandom"
require "tempfile"

module FakeFile
  module Generators
    class BaseGenerator
      def generate(_options = {})
        raise NotImplementedError, "#{self.class} must implement #generate"
      end

      private

      def build_tempfile(data, extension, encoding: "ASCII-8BIT")
        generated_file = Tempfile.new([SecureRandom.uuid, extension], encoding: encoding)
        generated_file.write(data)
        generated_file.rewind
        generated_file
      end
    end
  end
end
