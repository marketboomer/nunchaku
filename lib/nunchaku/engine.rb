require 'core_ext/string'
require 'core_ext/hash'
require 'responders'
require 'super_resources'
require 'closure_tree'
require 'has_scope'
require 'kaminari'
require 'ransack'
require 'draper'
require 'cancan'
require 'acts_as_list'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'sass-rails'
require 'bootstrap-sass'
require 'font-awesome-sass'
require 'bootstrap-datepicker-rails'
require 'bootstrap-x-editable-rails'
require 'select2-rails'
require 'gritter'
require 'wicked_pdf'
require 'sorted'
require 'csv'
require 'bluecloth'

module Nunchaku
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :fixture => false, :view_specs => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end
