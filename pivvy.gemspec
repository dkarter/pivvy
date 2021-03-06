# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pivvy/version'

Gem::Specification.new do |spec|
  spec.name          = 'pivvy'
  spec.version       = Pivvy::VERSION
  spec.authors       = ['Dorian Karter']
  spec.email         = ['dkarter@gmail.com']

  spec.summary       = %q{Get pivotal tracker stories into Vim}
  spec.description   = %q{Get Pivotal Tracker stories into Vim}
  spec.homepage      = 'https://hashrocket.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'thor'
  spec.add_dependency 'highline'
  spec.add_dependency 'tracker_api'
end
