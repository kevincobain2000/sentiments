# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sentiments/version'

Gem::Specification.new do |spec|
  spec.name          = "sentiments"
  spec.version       = Sentiments::VERSION
  spec.authors       = ["Pulkit Kathuria"]
  spec.email         = ["kevincobain2000@gmail.com"]
  spec.description   = %q{Sentiment Analysis with negation}
  spec.summary       = %q{Simple and Faster Sentiment Classifier categorizes sentence into positive & negative}
  spec.homepage      = "http://www8355ue.sakura.ne.jp/?action_classifiers_sentiment=true"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "json"
end
