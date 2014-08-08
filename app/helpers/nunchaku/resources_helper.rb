module Nunchaku::ResourcesHelper
  include Nunchaku::ResourcesPageHelper
  include Nunchaku::ResourcesInputHelper
  include Nunchaku::ResourcesSummaryHelper
  include Nunchaku::ResourcesButtonHelper
  include Nunchaku::ResourcesTabsHelper
  include Nunchaku::ResourcesCsvHelper
  include Nunchaku::ResourcesPdfHelper
  include Nunchaku::DebugHelper

  def create_or_update_resource_path(object)
    object.persisted? ? resource_path(object) : collection_path
  end

  def cancel_path
    collection_path
  end

  def nested_collection_name(klass = resource_class)
    nested? ? parent.decorate.to_s : human(klass).pluralize
  end

  def nested_resource_path resource
    polymorphic_path resource
  end
end