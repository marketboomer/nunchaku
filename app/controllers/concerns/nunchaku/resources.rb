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
end
