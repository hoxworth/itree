require File.join(File.dirname(__FILE__),"lib","itree","version")

Gem::Specification.new do |gem|
  gem.authors       = ["Kenny Hoxworth"]
  gem.email         = ["hoxworth@gmail.com"]
  gem.description   = "Interval Tree Data Structure"
  gem.summary       = "Interval Tree Data Structure"
  gem.homepage      = "http://github.com/hoxworth/itree"

  gem.files         = Dir["lib/**/*"]
  gem.test_files    = Dir["spec/**/*spec.rb"]
  gem.name          = "itree"
  gem.require_paths = ["lib"]
  gem.license       = "MIT"
  gem.version       = Intervals::VERSION

  gem.add_development_dependency 'rspec'
end
