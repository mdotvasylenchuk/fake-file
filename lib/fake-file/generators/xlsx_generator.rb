# frozen_string_literal: true

require "faker"
require "caxlsx"
require_relative "base_generator"

module FakeFile
  module Generators
    class XlsxGenerator < BaseGenerator
      def generate(_options = {})
        package = Axlsx::Package.new

        package.workbook.add_worksheet(name: "Fake data") do |sheet|
          sheet.add_row(["Title", "Value"])
          3.times do
            sheet.add_row([Faker::Book.title, rand(1..100)])
          end
        end

        build_tempfile(package.to_stream.read, ".xlsx")
      end
    end
  end
end
