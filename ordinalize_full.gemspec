# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "ordinalize_full"
  spec.version       = "3.0.0"
  spec.authors       = ["Cédric Félizard"]
  spec.email         = ["cedric@felizard.fr"]
  spec.summary       = "Turns a number into an ordinal string such as first, second, third or 1st, 2nd, 3rd."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/infertux/ordinalize_full"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0.0"

  spec.add_dependency "i18n", "~> 1.8"

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "cane"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.metadata["rubygems_mfa_required"] = "true"
end
