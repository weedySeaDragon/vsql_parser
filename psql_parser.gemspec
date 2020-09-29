# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

# Maintain the version:
require "psql_parser/version"

Gem::Specification.new do |s|
  s.name        = "psql_parser"
  s.version     = PsqlParser::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ashley Engelund","Tim Harper"]
  s.email       = ["ashley.engelund@gmail.com","tim@redbrainlabs.com"]
  s.homepage    = "http://github.com/weedySeaDragon/vsql_parser"
  s.summary     = "Postgres (Vertica) SQL Parser"
  s.description = "Provides treetop grammar for Vertica SQL. (Most likely works with Postgres SQL as well)"
  s.licenses    = ['MIT']

  s.files        = Dir.glob("{lib}/**/*") + %w(MIT_LICENSE)
  s.require_path = 'lib'

  s.add_dependency "treetop", "~> 1.4.0"

  s.add_development_dependency "rspec", ">= 2.10.0"
end
