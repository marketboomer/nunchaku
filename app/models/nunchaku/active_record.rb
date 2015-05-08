module Nunchaku
  class ActiveRecord < ActiveRecord::Base
    self.abstract_class = true

    include Resourceable
    include Reflections

    def to_sym
      to_s.titleize.delete(' ').underscore.to_sym
    end
  end
end
