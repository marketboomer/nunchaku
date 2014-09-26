module Nunchaku::Moving
  extend ActiveSupport::Concern

  included do
    helper_method :movable_collection
  end

  def sort
    ids = params[resource_params_name].map { |id| id.to_i }
    item = resource_class.find(moved_id(ids))
    item.insert_at(moved_to(ids,item)) # Using acts_as_list

    gflash :notice => t("flash.#{resource_class.name.underscore.pluralize.gsub('/', '.')}.sort.notice", { :resource_types =>  human(resource_class).pluralize })
  end

  protected

  def moved_id ids
    offset = first_changed_index(ids)
    new_candidate = ids[offset]
    old_candidate = original_ids[offset]
    new_delta = (ids.index(new_candidate) - original_ids.index(new_candidate)).abs
    old_delta = (ids.index(old_candidate) - original_ids.index(old_candidate)).abs
    new_delta > old_delta ? new_candidate : old_candidate
  end

  def first_changed_index ids
    ids.each_with_index do |id, i|
      return i if original_ids[i] != id
    end
  end

  def moved_to ids, item
    ids.index(item.id) + 1
  end

  def original_ids
    @original_ids ||= resource_class.where(id: params[resource_params_name]).order(:position).pluck(:id)
  end

  def movable_collection
    collection.except(:limit)
  end
end
