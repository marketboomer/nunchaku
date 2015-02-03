class Nunchaku::ResourcesController < Nunchaku::ApplicationController
  include Nunchaku::Resources

  AUTOCOMPLETE_LIMIT = 50

  around_filter :transactions_filter, :only => %w(create update)

	helper_method :collection_fields, :decorator_context

  def autocomplete
    respond_with autocomplete_collection.limit(AUTOCOMPLETE_LIMIT).map { |a| {:id => a.id, :text => a.to_s } }
  end

  def destroy(options = {}, &block)
    if destroy_resource
      options[:location] ||= collection_url
    else
      gflash :error => {:value => [resource.to_s, resource.errors.full_messages.join(', ')].join(': '), :class_name => 'error', :sticky => true}
    end
    respond_with(*(with_nesting(resource) << options), &block)
  end

  protected

  def resource_params
    params.require(resource_params_name) \
      .permit(permitted_params)
  end

  def permitted_params
    []
  end

  def transactions_filter
    ActiveRecord::Base.transaction do
      yield
    end
  end

  def collection_fields
    []
  end

  def decorator_context
    {}
  end

  def autocomplete_collection
    collection_translated_or_else_fuzzy
  end

  def collection_translated_or_else_fuzzy
    collection.send (collection.respond_to?(:translated_search) ? :translated_search : :fuzzy_search), search_terms
  end

  def autocomplete?
    controller.action_name == 'autocomplete'
  end
end

