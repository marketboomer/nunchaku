module Nunchaku::Filter
  extend ActiveSupport::Concern
  module ClassMethods
    def collection thing
      pluck(thing.to_sym).uniq #if respond_to?(thing)
    end
  end
end
