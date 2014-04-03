module Nunchaku::Moving
  extend ActiveSupport::Concern

  def sort
    collection = resource_class.where(:id => params[resource_instance_name])

    params[resource_instance_name].each_with_index do |id, i|
      r = collection.detect { |o| o.id == id.to_i}
      r.position = i + 1
      r.save
    end

    flash[:notice] = t("flash.#{resource_class.name.underscore.pluralize.gsub('/', '.')}.sort.notice", { :resource_types =>  human(resource_class).pluralize })
  end
end
