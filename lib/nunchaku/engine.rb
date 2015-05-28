require 'core_ext/string'
require 'core_ext/hash'
require 'csv'
require 'acts_as_list'
require 'closure_tree'
require 'bootstrap-datepicker-rails'
require 'bootstrap-sass'
require 'bootstrap-x-editable-rails'
require 'kramdown'
require 'coffee-rails'
require 'draper'
require 'font-awesome-sass'
require 'gritter'
require 'has_scope'
require 'httparty'
require 'jbuilder'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'kaminari'
require 'rails'
require 'ransack'
require 'responders'
require 'sass-rails'
require 'select2-rails'
require 'simple_form'
require 'sorted'
require 'state_machine'
require 'super_resources'
require 'uglifier'
require 'wicked_pdf'
require 'sourcify'

module Nunchaku
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :fixture => false, :view_specs => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    config.to_prepare do
      Nunchaku::ActiveRecord.alias_macros(
      #  has_many:

        integrates: %i(has_components divides_into),
        has_materials: %i(is_made_of is_partly is_defined_by is_detailed_by),
        has_portions_of: %i(has_slices_of),
      #  places:
        bunches: %i(groups collects describes_many plays_many),
        partners: %i(connects_through),

      #  owns:
      #  classifies:
      #  has_attachments:
        has_attributes: %i(has_properties associates_through),
        encompasses: %i(surrounds encloses contains houses),

      #  belongs_to:

        is_component_of: %i(is_part_of is_piece_of),
        makes: %i(defines details),
      #  is_portion_of:
        is_in_the_area_of: %i(is_placed_in),
        is_bunched_in: %i(is_surrounded_by is_grouped_by is_collected_by is_housed_by),
        is_partner_in: %i(connects),

      #  is_owned_by:
      #  is_classified_by:
        is_in: %i(visits is_located_in),
        is_attribute_of: %i(is_property_of ascribes_to associates links)
      )
    end
  end
end
