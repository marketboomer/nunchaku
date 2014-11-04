module Nunchaku::Decorated
  extend ActiveSupport::Concern

  included do
    helper 'nunchaku/decorated'
    helper_method :column_names, :summary_names, :decorator_class
  end

  protected

  def column_names
    decorator_class.column_names
  end

  def summary_names(model=resource)
    model.class.decorator_class.summary_names
  rescue NoMethodError => e
  end

  def decorator_class
    resource_class.decorator_class
  end
end
