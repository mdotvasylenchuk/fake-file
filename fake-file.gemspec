# frozen_string_literal: true

require_relative "lib/fake-file/version"

Gem::Specification.new do |spec|
  spec.name = "fake-file"
  spec.version = FakeFile::VERSION
  spec.authors = ["VasylenchukMischa"]
  spec.email = ["mischa.blaster@gmail.com"]

  spec.summary = "a ruby library to create fake files"
  spec.description = "gem used different libraries to create fake file as fast as these libraries work"
  spec.homepage = "https://github.com/VasylenchukMischa/fake-file"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = 'https://github.com/VasylenchukMischa/fake-file'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "prawn-html"
  spec.add_dependency "docxify"
  spec.add_dependency "caxlsx"
  spec.add_dependency "faker"
  spec.add_dependency "matrix"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "marcel"
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
