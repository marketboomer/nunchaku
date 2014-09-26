module Nunchaku::Moving
  extend ActiveSupport::Concern

  included do
    helper_method :movable_collection
  end

  def sort
    ids = params[resource_params_name].map { |id| id.to_i }
    item = first_moved_item(ids)
    item.insert_at(moved_to(ids,item)) # Using acts_as_list

    gflash :notice => t("flash.#{resource_class.name.underscore.pluralize.gsub('/', '.')}.sort.notice", { :resource_types =>  human(resource_class).pluralize })
  end

  protected

  def first_moved_item ids
    ids.each_with_index do |id, i|
      return resource_class.find(collection_array[i]) if collection_array[i] != id
    end
    nil
  end

  def moved_to ids, item
    ids.index(item.id) + 1
  end

  def movable_collection
    collection.except(:limit)
  end

  def collection_array
    @collection_array ||= resource_class.where(:id => params[resource_params_name]).order(:position).pluck(:id)
  end

end
