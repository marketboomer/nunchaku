module Nunchaku
  module Composition
    module MemberBunch
      extend ActiveSupport::Concern

      module ClassMethods
        def bunches(*args, &block)
          has_many(*args, &block)
        end

        def is_bunched_in(*args)
          belongs_to(*args)
        end
      end
    end
  end
end
