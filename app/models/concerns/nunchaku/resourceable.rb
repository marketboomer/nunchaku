module Nunchaku
  module Resourceable
    extend ActiveSupport::Concern

    include Relational
    include Reflections
    include Pairable
    include Cacheable

    def with_ancestors
      respond_to?(:self_and_ancestors) ? self_and_ancestors : [self]
    end
  end
end
