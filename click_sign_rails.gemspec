lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'click_sign_rails'
  s.version     = '0.0.2'
  s.summary     = "ClickSign Api interface for rails"
  s.authors     = ["Thiago Soares de Melo"]
  s.email       = 'thiago.soaresm19@gmail.com'
  s.files       = Dir["{lib}/**/*", "MIT-LICENSE", "README.md"]
  s.homepage    = 'https://github.com/teago19/click-sign-rails'
  s.license     = 'MIT'

  s.add_dependency "rails", "~> 6"
  s.add_dependency "rest-client", "2.1.0"
end