lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'salt-lint/version'

Gem::Specification.new do |spec|
  spec.name = 'salt-lint'
  spec.version = SaltLint::VERSION
  spec.authors = ['Lukasz Raczylo']
  spec.email = ['lukasz@raczylo.com']
  spec.summary = %q{Salt linter written in Ruby}
  spec.description = 'Created as nobody from Salt community created one till today.'
  spec.homepage = 'https://github.com/lukaszraczylo/salt-lint'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>=1.9.2'
  spec.add_development_dependency 'awesome_print', '~> 1.2.0', '>= 1.2.0'
  spec.add_development_dependency 'trollop','2.1.2', '>= 2.1.2'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.0', '>= 10.0.0'
  spec.add_development_dependency 'rspec', '~> 2.6'
end