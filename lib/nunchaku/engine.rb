require 'core_ext/string'
require 'core_ext/hash'
require 'super_resources'
require 'cancan'
require 'acts_as_list'
require 'sass-rails'
require 'bootstrap-sass'
require 'font-awesome-sass'
require 'bootstrap-datepicker-rails'
require 'select2-rails'
require 'sorted'
require 'csv'

module Nunchaku
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :fixture => false, :view_specs => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w(nunchaku/nunchaku.js nunchaku/application.css)
    end

  end
end
