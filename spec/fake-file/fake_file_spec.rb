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

  it "returns uploaded pdf via facade" do
    uploaded_file = FakeFile.upload(:pdf)

    expect(uploaded_file).to be_a(Rack::Test::UploadedFile)
    expect(uploaded_file.content_type).to eq("application/pdf")
    expect(uploaded_file.original_filename).to eq("pdf.pdf")
  end

  it "returns uploaded docx via facade" do
    uploaded_file = FakeFile.upload(:docx)

    expect(uploaded_file).to be_a(Rack::Test::UploadedFile)
    expect(uploaded_file.content_type).to eq("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    expect(uploaded_file.original_filename).to eq("docx.docx")
  end

  it "returns uploaded xlsx via facade" do
    uploaded_file = FakeFile.upload(:xlsx)

    expect(uploaded_file).to be_a(Rack::Test::UploadedFile)
    expect(uploaded_file.content_type).to eq("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    expect(uploaded_file.original_filename).to eq("xlsx.xlsx")
  end

  it "raises for unsupported format" do
    expect { FakeFile.generate(:doc) }
      .to raise_error(FakeFile::Registry::UnsupportedFormatError, "Unsupported format: :doc")
  end

  it "raises for unsupported upload format" do
    expect { FakeFile.upload(:doc) }
      .to raise_error(FakeFile::Registry::UnsupportedFormatError, "Unsupported format: :doc")
  end
end
