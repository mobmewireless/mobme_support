lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'mobme_support/version'

Gem::Specification.new do |s|
  s.name        = "mobme_support"
  s.version     = MobME::Infrastructure::Utilities::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["MobME"]
  s.email       = ["engineering@mobme.in"]
  s.homepage    = "http://42.mobme.in/"
  s.summary     = %q{MobME Support are classes and standard library extensions shared across projects, brought under one roof.}
  s.description = %q{MobME Support is a collection of classes and standard library extensions extracted from across MobME projects & for great good. Ala ActiveSupport!}

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "i18n"
  s.add_dependency "activesupport"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "flog"
  s.add_development_dependency "yard"
  s.add_development_dependency "ci_reporter"
  s.add_development_dependency "simplecov-rcov"
  s.add_development_dependency "rdiscount"

  s.files              = `git ls-files`.split("\n") - ["Gemfile.lock", ".rvmrc"]
  s.test_files         = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths      = ["lib"]
end
