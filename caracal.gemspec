# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caracal/version'

Gem::Specification.new do |spec|
  spec.name          = 'caracal_the_curve'
  spec.version       = Caracal::VERSION
  spec.authors       = ['Trade Infomatics', 'John Dugan', 'James Ridgway', 'Matthew Barber', 'Odilon Relucio']
  spec.email         = ['jpdugan@gmail.com', 'james.ridgway@tccs.io', 'matthew.barber@tccs.io', 'odi@loudcloud.ph']
  spec.summary       = %q{ Fast, professional Microsoft Word (docx) writer for Ruby. }
  spec.description   = %q{ Caracal is a pure Ruby Microsoft Word generation library that produces professional quality MSWord documents (docx) using a simple, HTML-style DSL. }
  spec.homepage      = 'https://github.com/trade-informatics/caracal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'rubyzip',  ['>= 1.1.0', '< 3.0']
  spec.add_dependency 'tilt',     '>= 1.4'

  spec.add_development_dependency 'bundler',  '~> 2.4'
  spec.add_development_dependency 'rake',     '~> 10.0'
  spec.add_development_dependency 'rspec',    '~> 3.0'
end
