class Nunchaku::ResourcesController < Nunchaku::ApplicationController
  include Nunchaku::Resources

  around_filter :transactions_filter, :except => %w(index edit show)

	helper_method :collection_fields, :decorator_context

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
end
