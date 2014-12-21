# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "rspec-todo"
  spec.version       = File.read(File.expand_path("VERSION", File.dirname(__FILE__))).chomp
  spec.authors       = ["okitan"]
  spec.email         = ["okitakunio@gmail.com"]
  spec.description   = "todo: pending if failed"
  spec.summary       = "todo: pending if failed"
  spec.homepage      = "https://github.com/okitan/rspec-todo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rspec", "~> 2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  # debug
  spec.add_development_dependency "pry"
  spec.add_development_dependency "tapp"
end
