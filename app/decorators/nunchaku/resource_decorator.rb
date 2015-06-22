class Nunchaku::ResourceDecorator < Draper::Decorator
  include Nunchaku::TableDecorator

  delegate_all

  alias_method :resource, :source

  class << self
    def decorator_class
      self
    end

    def index_widgets
      index_widget_proportions.stringify_keys.keys
    end

    def index_widget_width(w)
      index_widget_proportions[w.to_sym]
    end

    def index_widget_proportions
      {
        :table => 12
      }
    end

    def index_filter_partials
      []
    end

    def column_names
      source_class.attribute_names - %w(id created_at updated_at lock_version)
    end

    def csv_column_names
      column_names
    end

    def form_column_names
      column_names + %w(save)
    end

    def form_element_names
      column_names
    end

    def summary_element_names
      form_element_names
    end

    def human_names(attrs_nonhuman = columns_names)
      h.human_attrs(source_class, attrs_nonhuman)
    end

    def report_name
      ''
    end

    def table_style
      'table'
    end

    def tree_node_classes(node)
      ''
    end

    def tree_node_content(node)
      node.to_s
    end
  end

  def resource_class
    self.class.source_class
  end

  def human_names(attrs_nonhuman = columns_names)
    self.class.human_names(attrs_nonhuman = columns_names)
  end

  def api_required_attributes
    %w()
  end
end
