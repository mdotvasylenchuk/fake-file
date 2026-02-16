# frozen_string_literal: true

require "faker"
require "prawn-html"
require_relative "base_generator"

module FakeFile
  module Generators
    class PdfGenerator < BaseGenerator
      def generate(_options = {})
        pdf = Prawn::Document.new
        html = "<h1>#{Faker::Book.title}</h1><p>#{Faker::Lorem.paragraph}</p>"
        PrawnHtml.append_html(pdf, html)
        build_tempfile(pdf.render, ".pdf")
      end
    end
  end
end
