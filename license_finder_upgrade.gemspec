# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'license_finder_upgrade/platform'
require 'license_finder_upgrade/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 1.9.3'
  spec.name          = "license_finder_upgrade"
  spec.version       = LicenseFinderUpgrade::VERSION

  spec.authors       = ["Jacob Maine"]

  spec.email         = [""]
  spec.homepage      = ""
  spec.summary       = %q{Upgrade helper for license_finder}
  spec.description   = %q{This tool helps upgrade license_finder projects from version 1.2 to 2.0.}

  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sequel"
  spec.add_dependency LicenseFinderUpgrade::Platform.sqlite_gem

  spec.add_development_dependency "rspec", "~> 3"

  spec.platform = "java" if LicenseFinderUpgrade::Platform.java?
end
