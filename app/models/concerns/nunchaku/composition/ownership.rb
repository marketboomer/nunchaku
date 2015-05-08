module Nunchaku
  module Composition
    module Ownership
      extend ActiveSupport::Concern

      module ClassMethods
        def owns(*args, &block)
          has_many(*args, &block)
        end

        def is_owned_by(*args)
          belongs_to(*args)
        end
      end
    end
  end
end
