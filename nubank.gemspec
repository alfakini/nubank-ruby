
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nubank/version'

Gem::Specification.new do |spec|
  spec.name = 'nubank'
  spec.version = Nubank::VERSION
  spec.authors = ['Alan R. Fachini']
  spec.email = ['alfakini@gmail.com']
  spec.summary = "A wrapper to Nubank's public API."
  spec.description = "This gem provides a wrapper to Nubank's public API. It does not have any official support from Nubank nor is endorsed by them. This code is provided as is, I can't give you any guarantee that Nubank won't change the API calls in the future or you block your access accidentaly by overloading their API."
  spec.homepage = 'https://www.github.com/alfakini/nubank-ruby'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |file| File.basename(file) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 0.15.2'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'coveralls', '~> 0.8.22'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.58.2'
  spec.add_development_dependency 'vcr', '~> 4.0.0'
  spec.add_development_dependency 'webmock', '~> 3.4.2'
end
