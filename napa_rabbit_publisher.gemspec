# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'napa_rabbit_publisher/version'

Gem::Specification.new do |spec|
  spec.name          = "napa_rabbit_publisher"
  spec.version       = NapaRabbitPublisher::VERSION
  spec.authors       = ["Jay OConnor"]
  spec.email         = ["jay@bellycard.com"]
  spec.description   = %q{This provides an easy to use library with an AMQP Singleton for connecting and sending data to RabbitMQ}
  spec.summary       = %q{This provides an easy to use library with an AMQP Singleton for connecting and sending data to RabbitMQ}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'bunny'
  spec.add_dependency 'napa'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "activerecord", "~> 4.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'sqlite3'
end
