$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "faceauth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "faceauth"
  s.version     = Faceauth::VERSION
  s.authors     = ["Sam"]
  s.email       = ["sandeep@rubyeffect.com"]
  s.homepage    = "http://rubyeffect.com"
  s.summary     = "Summary of Faceauth."
  s.description = "Description of Faceauth."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency 'mysql2', '~> 0.4.4'
  s.add_development_dependency 'findface', '~> 0.0.1'
  s.add_development_dependency 'jpeg_camera', "~> 1.3.2"
end
