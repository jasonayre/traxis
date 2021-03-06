# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traxis/version'

Gem::Specification.new do |spec|
  spec.name          = "traxis"
  spec.version       = Traxis::VERSION
  spec.authors       = ["Jason Ayre"]
  spec.email         = ["jasonayre@gmail.com"]
  spec.summary       = %q{Strongly opinionated restful api convention > config for praxis}
  spec.description   = %q{Making Praxis more like rails with active record, inherited resources inspired conventions}
  spec.homepage      = "http://github.com/jasonayre/traxis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "will_paginate"

  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "praxis"
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'rspec-its', '~> 1'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1'
  spec.add_development_dependency 'guard', '~> 2'
  spec.add_development_dependency 'guard-rspec', '~> 4'
  spec.add_development_dependency 'guard-bundler', '~> 2'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'rack-test', '~> 0'
  spec.add_development_dependency 'simplecov', '~> 0'
  spec.add_development_dependency 'terminal-notifier-guard'
end
