module Nunchaku::TableDecorator
  extend ActiveSupport::Concern

  module ClassMethods
    def table_heading(*args)
      column = args.first

      h.tooltip(:title => h.t("tooltip.#{source_class.name.underscore}.#{column}.heading", :default => '')) do
        heading_label(*args)
      end
    end

    def edit_in_table
      {}
    end

    protected

    def heading_label(column, links=true)
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
  end

  def table_cell(column)
    h.tooltip(:title => h.t("tooltip.#{resource.class.name.underscore}.#{column}.cell", :default => ''), 'data-placement' => 'left') do
      unless column.in?(self.class.edit_in_table)
        send(column)
      else
        h.text_field_tag("#{resource.class.name.underscore}_#{column}[#{resource.id}]", send(column), :model_id => resource.id, :class => "#{resource.class.name.underscore.gsub('/', '_')}_#{column}_input")
      end
    end
  end

  def tints(*args)
  end
end
