module Nunchaku
  class ActiveRecord < ActiveRecord::Base
    self.abstract_class = true    

    include Resourceable
    include Reflections
  end
end
