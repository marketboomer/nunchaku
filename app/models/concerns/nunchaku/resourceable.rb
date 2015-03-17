module Nunchaku
  module Resourceable
    extend ActiveSupport::Concern

    include Relational
    include Reflections
    include Pairable
    include Cacheable
  end
end
