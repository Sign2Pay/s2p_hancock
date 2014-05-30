# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's2p_hancock/version'

Gem::Specification.new do |spec|
  spec.name          = "s2p_hancock"
  spec.version       = S2PHancock::VERSION
  spec.authors       = ["Nick Lloyd"]
  spec.email         = ["nick@nicklloyd.co"]
  spec.summary       = %q{API wrapper for sending and receiving messages to/from Sign2Pay's Signature Verification Service - Hancock}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus", "~> 0.6.8"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

end