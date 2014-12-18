module Nunchaku
  module ResourcesHelper
    include ResourcesPageHelper
    include ResourcesInputHelper
    include ResourcesButtonHelper
    include ResourcesTabsHelper
    include ResourcesCsvHelper
    include ResourcesPdfHelper
    include DebugHelper

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
  end
end
