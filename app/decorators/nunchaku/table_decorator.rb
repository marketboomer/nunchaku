module Nunchaku::TableDecorator
  extend ActiveSupport::Concern

  module ClassMethods
    def table_heading(column, links=true)
      label = source_class.human_attribute_name(column.to_sym).titleize
      return label unless links
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
      h.text_field_tag("#{resource.class.name.underscore}_#{column}[#{resource.id}]", send(column), table_cell_edit_options(column))
    end
  end


  def table_cell_edit_options column
    {:model_id => resource.id, :class => "#{resource.class.name.underscore.gsub('/', '_')}_#{column}_input"}
  end

  def tints(*args)
  end
end