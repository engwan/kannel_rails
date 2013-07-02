$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kannel_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kannel_rails"
  s.version     = KannelRails::VERSION
  s.authors     = ["Heinrich Lee Yu"]
  s.email       = ["hleeyu@gmail.com"]

  s.summary     = "Kannel integration for Rails"
  s.description = "Kannel integration for Rails"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "rspec-rails"
  s.add_dependency "webmock"
end
