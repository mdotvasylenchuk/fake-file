# frozen_string_literal: true

RSpec.describe FakeFile do
  it "has a version number" do
    expect(FakeFile::VERSION).not_to be nil
  end

  it "returns pdf file via facade" do
    expect(Marcel::MimeType.for(FakeFile.pdf)).to eq("application/pdf")
  end

  it "returns docx file via facade" do
    expect(Marcel::MimeType.for(FakeFile.docx)).to eq("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
  end

  it "returns xlsx file via facade" do
    expect(Marcel::MimeType.for(FakeFile.xlsx)).to eq("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  end

  it "raises for unsupported format" do
    expect { FakeFile.generate(:doc) }
      .to raise_error(FakeFile::Registry::UnsupportedFormatError, "Unsupported format: :doc")
  end
end
