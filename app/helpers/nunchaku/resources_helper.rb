module Nunchaku::ResourcesHelper
  include Nunchaku::ResourcesPageHelper
  include Nunchaku::ResourcesInputHelper
  include Nunchaku::ResourcesButtonHelper
  include Nunchaku::ResourcesTabsHelper
  include Nunchaku::ResourcesCsvHelper
  include Nunchaku::ResourcesPdfHelper
  include Nunchaku::DebugHelper

  def create_or_update_resource_path(object, without_nesting=false)
    unless object.persisted?
      collection_path
    else
      without_nesting ? object : resource_path(object)
    end
  end

  def cancel_path
    collection_path
  end

  def nested_collection_name(klass = resource_class)
    nested? ? outer.decorate.to_s : human(klass).pluralize
  end

  def nested_collection_type(klass = resource_class)
    nested? ? human(outer.class) : ''
  end

  def nested_resource_path resource
    polymorphic_path resource
  end

  def cell_classes column
    ["cell", column, resource.try(:clickable_row?) ? "clickable" : nil].compact.join(' ')
  end

  def resource_cell_link resource
    resource_path(resource) if resource.try(:clickable_row?)
  end
end
