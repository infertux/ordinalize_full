# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "ordinalize_full"
  spec.version       = "1.5.0"
  spec.authors       = ["Cédric Félizard"]
  spec.email         = ["cedric@felizard.fr"]
  spec.summary       = "Turns a number into an ordinal string such as first, second, third or 1st, 2nd, 3rd."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/infertux/ordinalize_full"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.8"

  spec.add_dependency "i18n", "~> 0.8"

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "cane"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rubocop"
end
