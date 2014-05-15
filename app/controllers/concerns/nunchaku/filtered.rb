module Nunchaku::Filtered
  extend ActiveSupport::Concern

  included do
    helper_method :filter
  end

  protected

  def collection
    memoize_collection do
      no_filter? ? super : apply_filter(super)
    end
  end

  def apply_filter(relation)
    relation.where(filter_scope).search(filter_params).result(distinct_params)
  end

  def filter_params_name
    :q
  end

  def filter_params
    (params[filter_params_name] || {}).merge(sort_params)
  end

  # TODO: Remove sidx and sord for consistency with sorted.
  def sort_params
    (params[:sidx] && params[:sord]) ? {:s => "#{params[:sidx]} #{params[:sord]}"} : {}
  end

  def filter
    @filter ||= resource_class.search(filter_params)
  end

  def filter_scope
    {}
  end

  def distinct_params # TODO : MUST CHANGE THIS! BAAAAAAD FOR PERFORMANCE!
    {:distinct => true} # Note: Override this to {} if you need to sort by an association
  end

  def no_filter?
    filter_params.empty? || filter_params.map { |k, v| v }.compact.empty?
  end
end