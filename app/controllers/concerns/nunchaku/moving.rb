module Nunchaku::Moving
  extend ActiveSupport::Concern

  def sort
    params[resource_instance_name].each_with_index do |id, i|
      r = collection_hash[id.to_i]
      r.position = i + 1
      r.save
    end

    flash[:notice] = t("flash.#{resource_class.name.underscore.pluralize.gsub('/', '.')}.sort.notice", { :resource_types =>  human(resource_class).pluralize })
  end

  protected

  def collection_hash
    @collection_hash ||= Hash[ resource_class.where(:id => params[resource_instance_name]).all.map { |o| [o.id,o] } ]
  end
end
