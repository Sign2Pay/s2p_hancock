# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's2p_hancock/version'

Gem::Specification.new do |spec|
  spec.name          = "s2p_hancock"
  spec.version       = S2PHancock::VERSION
  spec.authors       = ["Nick Lloyd"]
  spec.email         = ["nick@nicklloyd.co"]
  spec.summary       = %q{API wrapper for interacting with Sign2Pay's Signature Verification Service - Hancock}
  spec.description   = %q{API wrapper for sending and receiving messages to/from Sign2Pay's Signature Verification Service - Hancock}
  spec.homepage      = "https://github.com/Sign2Pay/s2p_hancock"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus", '~> 0.6', '>= 0.6.8'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 2.0", '>= 2.9.2'
  spec.add_development_dependency "webmock", "~> 1.0", ">= 1.17.4"
  spec.add_development_dependency 'guard', '~> 2.6'
  spec.add_development_dependency 'guard-rspec', '~> 4.2', '>= 4.2.9'
  spec.add_development_dependency 'simplecov', '~> 0.7', '>= 0.7.1'
end
