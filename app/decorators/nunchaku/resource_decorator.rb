class Nunchaku::ResourceDecorator < Draper::Decorator
  include Nunchaku::TableDecorator
  include Nunchaku::InPlaceEditing

  delegate_all

  alias_method :resource, :source

  class << self
    def decorator_class
      self
    end

    def column_names
      source_class.attribute_names - %w(id created_at updated_at lock_version)
    end

    def form_element_names
      column_names
    end

    def human_names(attrs_nonhuman = columns_names)
      h.human_attrs(source_class, attrs_nonhuman)
    end

    def report_name
      ''
    end
  end

  def resource_class
    self.class.source_class
  end

  def human_names(attrs_nonhuman = columns_names)
    self.class.human_names(attrs_nonhuman = columns_names)
  end
end
