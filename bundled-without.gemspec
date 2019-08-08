#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "bundled-without"
  s.version     = "0.0.2"
  s.authors     = ["Michal Papis"]
  s.email       = ["mpapis@gmail.com"]
  s.homepage    = "http://github.com/mpapis/bundled-without"
  s.description =
  s.summary     = %q{Hack bundler to not generate BUNDLED WITH}
  s.license     = 'MIT'

  s.files       = `git ls-files`.split("\n")

  s.add_dependency "bundler-unload", ">=1.0.2"
  s.add_dependency "executable-hooks", ">=1.5.0"
end
