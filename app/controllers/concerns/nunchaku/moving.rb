module Nunchaku::Moving
  extend ActiveSupport::Concern

  included do
    helper_method :movable_collection
  end

  def sort
    item = resource_class.find(moved_id)
    item.insert_at(moved_to(item)) # Using acts_as_list

    gflash :notice => t("flash.#{resource_class.name.underscore.pluralize.gsub('/', '.')}.sort.notice", { :resource_types =>  human(resource_class).pluralize })
  end

  protected

  def moved_id
    moved_candidate(first_changed_index)
  end

  def moved_candidate(offset)
    delta(sorted_ids[offset]) > delta(original_ids[offset]) ? sorted_ids[offset] : original_ids[offset]
  end

  def delta(candidate)
    (sorted_ids.index(candidate) - original_ids.index(candidate)).abs
  end

  def first_changed_index
    sorted_ids.each_with_index do |id, i|
      return i if original_ids[i] != id
    end
  end

  def moved_to item
    sorted_ids.index(item.id) + 1
  end

  def sorted_ids
    @sorted_ids ||= params[resource_params_name].map { |id| id.to_i }
  end

  def original_ids
    @original_ids ||= resource_class.where(id: params[resource_params_name]).order(:position).pluck(:id)
  end

  def movable_collection
    collection.except(:limit)
  end
end
