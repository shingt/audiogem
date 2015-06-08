# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'audio/version'

Gem::Specification.new do |spec|
  spec.name          = "audio"
  spec.version       = Audio::VERSION
  spec.authors       = ["shingt"]
  spec.email         = ["van.s.ver@gmail.com"]
  spec.summary       = %q{audio tuning gem}
  spec.description   = %q{Simulation for sound frequencies.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
