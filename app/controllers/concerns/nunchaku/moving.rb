module Nunchaku::Moving
  extend ActiveSupport::Concern

  included do
    helper_method :movable_collection
  end

  def sort
    params[resource_params_name].each_with_index do |id, i|
      r = collection_hash[id.to_i]
      r.position = i + 1
      r.save
    end

    gflash :notice => t("flash.#{resource_class.name.underscore.pluralize.gsub('/', '.')}.sort.notice", { :resource_types =>  human(resource_class).pluralize })
  end

  protected

  def movable_collection
    collection.except(:limit)
  end

  def collection_hash
    @collection_hash ||= Hash[ resource_class.where(:id => params[resource_params_name]).map { |o| [o.id,o] } ]
  end
end
