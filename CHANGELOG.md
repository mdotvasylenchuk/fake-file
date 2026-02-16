## [Unreleased]

### Added

- Extensible generator architecture (`Strategy + Registry`) with dedicated generators for `pdf`, `docx`, and `xlsx`
- Shared `BaseGenerator` for reusable tempfile creation logic
- New facade API: `FakeFile.generate`, `FakeFile.pdf`, `FakeFile.docx`, `FakeFile.xlsx`

### Changed

- Replaced `htmltoword` with `docxify` for DOCX generation
- Replaced `axlsx` with `caxlsx` for modern Ruby compatibility
- Dropped legacy `FakeFile::Document.*` API support
- Updated specs to cover facade API and unsupported format behavior

## [0.1.0] - 2022-06-29

- Initial release
