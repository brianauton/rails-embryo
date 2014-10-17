require File.expand_path("../lib/rails-embryo/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "rails-embryo"
  s.version = Rails::Embryo::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Brian Auton"]
  s.email = ["brianauton@gmail.com"]
  s.homepage = "http://github.com/brianauton/rails-embryo"
  s.summary = "Generators for quick setup of advanced Rails practices"
  s.license = "MIT"
  s.required_rubygems_version = ">= 1.3.6"
  s.files = Dir.glob("lib/**/*") + ["README.md", "History.md", "License.txt"]
  s.require_path = "lib"
  s.executables = ["rails-embryo"]
  s.add_dependency "rails", "~> 4.1"
  s.add_development_dependency "rspec", "~> 3.1.0"
  s.add_development_dependency "rake", "~> 0"
end
