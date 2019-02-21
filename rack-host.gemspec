# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/host/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-host'
  spec.version       = Rack::Host::VERSION
  spec.authors       = ['Assembly Education']
  spec.email         = ['developers@assembly.education']

  spec.summary       = %q{Only accept requests for specific hosts}
  spec.description   = %q{Rack middleware to 404 requests that aren't to whitelisted hostnames}
  spec.homepage      = 'https://github.com/assembly-edu/rack-host'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rack'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rack-test'
end
