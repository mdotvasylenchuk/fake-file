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

  it "supports format aliases through registry" do
    docx_file = FakeFile.generate(:doc)
    xlsx_file = FakeFile.generate(:xls)

    expect(Marcel::MimeType.for(docx_file)).to eq("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    expect(Marcel::MimeType.for(xlsx_file)).to eq("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  end

  it "keeps backward compatibility for document class" do
    expect(Marcel::MimeType.for(FakeFile::Document.pdf)).to eq("application/pdf")
  end
end
