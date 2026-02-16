# frozen_string_literal: true

require "faker"
require "docxify"
require_relative "base_generator"

module FakeFile
  module Generators
    class DocxGenerator < BaseGenerator
      def generate(_options = {})
        docx = DocXify::Document.new
        docx.default_styling(color: "#000000")
        docx.add_paragraph(Faker::Book.title)
        docx.add_paragraph(Faker::Lorem.paragraph)
        build_tempfile(docx.render, ".docx")
      end
    end
  end
end
