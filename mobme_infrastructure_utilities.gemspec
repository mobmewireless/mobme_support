lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'mobme_infrastructure_utilities/version'

Gem::Specification.new do |s|
  s.name        = "mobme_infrastructure_utilities"
  s.version     = MobME::Infrastructure::Utilities::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["MobME"]
  s.email       = ["engineering@mobme.in"]
  s.homepage    = "http://mobme.in/"
  s.summary     = %q{Utility classes and standard library extensions shared across projects, brought under one roof.}
  s.description = %q{Utility is a collection of classes and standard library extensions extracted from across MobME projects, for great good.}

  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "rspec"

  s.files              = `git ls-files`.split("\n") - ["Gemfile.lock", ".rvmrc"]
  s.test_files         = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths      = ["lib"]
end
