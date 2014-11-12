module Nunchaku::Resources
  extend ActiveSupport::Concern

  include Nunchaku::Responding
  include SuperResources::Controller
  include Nunchaku::Filtered
  include Nunchaku::Paginated
  include Nunchaku::Decorated

  included do
    helper 'nunchaku/resources'
  end

  module ClassMethods
    def parent_prefixes
      @parent_prefixes ||= %w(resources) + super
    end
  end

  protected

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