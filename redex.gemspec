# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "redex/version"

Gem::Specification.new do |spec|
  spec.name          = "redex"
  spec.version       = Redex::VERSION
  spec.authors       = ["Ateliê de Software - Webgoal", "Aluan Henrique" "Gustavo Canedo"]
  spec.email         = ["contato@atelie.software"]

  spec.summary       = %q{Uma gem para integração com o sistema de pagamentos eRede}
  spec.homepage      = "https://github.com/webgoal/redex"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "canned_soap", "~>0.1", ">=0.1.2"
end
