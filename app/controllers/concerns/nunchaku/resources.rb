module Nunchaku
  module Resources
    extend ActiveSupport::Concern

    include Responding
    include SuperResources::Controller
    include Filtered
    include Paginated
    include Decorated

    included do
      helper 'nunchaku/resources'
    end

    module ClassMethods
      def parent_prefixes
        @parent_prefixes ||= %w(resources) + super
      end
    end

    protected

    def collection
      treed_index? ? super.roots : super
    end

    def treed_index?
      !nested? && decorator_class.index_widgets.include?('tree')
    end

    def paged_formats
      treed_index? ? (super + [:json]) : super
    end

    def nullify_empty_params
      params.deep_blank_to_nulls!
    end

    def resource_from_params(resource_name)
      unless (rfp = resource_params_id(resource_name)).blank?
        resource_name.to_s.classify.safe_constantize.find(rfp)
      end
    end

    def resource_params_id(resource_name)
      params["#{resource_name.classify.demodulize.underscore}_id"]
    end
  end
end
