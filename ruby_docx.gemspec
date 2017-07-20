# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_docx/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_docx"
  spec.version       = RubyDocx::VERSION
  spec.authors       = ["Joey Lin"]
  spec.email         = ["joeyoooooo@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'nokogiri', '~> 1.5'
  spec.add_dependency 'rubyzip',  '~> 1.1.6'
  spec.add_dependency 'mimemagic'
  spec.add_dependency 'texmath-ruby'
  spec.add_dependency 'calculus'
  spec.add_dependency 'mathtype'
  spec.add_dependency 'pry'
  spec.add_dependency 'mathtype_to_mathml'
end
