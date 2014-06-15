Gem::Specification.new do |spec|
  spec.name          = "webservice-swigclient"
  spec.version       = '0.0.1'
  spec.authors       = ["Logan Bell"]
  spec.email         = ["lbell@shutterstock.com"]
  spec.description   = %q{A client for swig.io!}
  spec.summary       = %q{cool cool}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
