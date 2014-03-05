require 'core_ext/string'
require 'core_ext/hash'
require 'super_resources'
require 'cancan'
require 'acts_as_list'
require 'less-rails'
require 'less-rails-bootstrap'
require 'less-rails-fontawesome'
require 'bootstrap-datepicker-rails'
require 'select2-rails'
require 'bootstrap-x-editable-rails'
require 'sorted'
require 'csv'
  
module Nunchaku
  class Engine < ::Rails::Engine
    isolate_namespace Nunchaku

    config.generators do |g|
      g.test_framework :rspec, :fixture => false, :view_specs => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    config.assets.paths << 'app/assets/fonts'
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
  end
end