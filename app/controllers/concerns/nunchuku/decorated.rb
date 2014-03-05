module Nunchaku::Decorated
  extend ActiveSupport::Concern

  included do
    helper 'nunchaku/decorated'
    helper_method :column_names, :decorator_class
  end

  protected

  def column_names
    decorator_class.column_names
  end

  def decorator_class
    resource_class.decorator_class
  end
end