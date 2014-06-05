$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nunchaku/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nunchaku"
  s.version     = Nunchaku::VERSION
  s.authors     = ["Marketboomer"]
  s.email       = ["info@marketboomer.com"]
  s.homepage    = "http://www.marketboomer.com"
  s.summary     = "Base engine for Market Boomer"
  s.description = "Base engine for Market Boomer"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # runtime dependencies .......................................................

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency 'sass-rails', '~> 4.0.0'
  s.add_dependency 'bootstrap-sass', '~> 3.1.1'
  s.add_dependency "font-awesome-sass"

  s.add_dependency "awesome_nested_set", "~> 2.1"
  s.add_dependency "state_machine", "~> 1.2"

  s.add_dependency 'acts_as_list'
  s.add_dependency 'sorted'
  s.add_dependency 'responders'
  s.add_dependency 'has_scope'
  s.add_dependency 'kaminari'
  s.add_dependency 'draper'
  s.add_dependency 'ransack'
  s.add_dependency 'simple_form'
  s.add_dependency 'chosen-rails'
  s.add_dependency 'select2-rails'
  s.add_dependency 'bootstrap-datepicker-rails'
  s.add_dependency 'bootstrap-x-editable-rails'

  s.add_dependency 'super_resources'

  # development dependencies ...................................................

  s.add_development_dependency "sqlite3"

  s.add_development_dependency 'sextant'
end
