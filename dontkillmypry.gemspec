# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "dontkillmypry"
  spec.version       = "0.0.1"
  spec.authors       = ["Chris Erin"]
  spec.email         = ["chris.erin@gmail.com"]
  spec.summary       = %q{Allow pry sessions when inside capybara actions}
  spec.description   = %q{Allow pry sessions when inside capybara actions}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
