module Nunchaku::TableDecorator
  extend ActiveSupport::Concern

  module ClassMethods
    def table_heading(column)
      label = source_class.human_attribute_name(column.to_sym).titleize

      case      
      when respond_to?("#{column}_heading")
        send("#{column}_heading", label)

      when column.in?(source_class.column_names)
        h.link_to_sorted(label, column)

      else
        label
      end
    end

    def edit_in_table
      {}
    end
  end

  def table_cell(column)
    unless column.in?(self.class.edit_in_table)
      send(column)
    else
      h.text_field_tag("#{resource.class.name.underscore}_#{column}[#{resource.id}]", send(column), :model_id => resource.id, :class => "#{resource.class.name.underscore.gsub('/', '_')}_#{column}_input")
    end
  end

  def tints
  end
end