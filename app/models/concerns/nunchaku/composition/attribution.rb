module Nunchaku
  module Composition
    module Attribution
      extend ActiveSupport::Concern

      module ClassMethods
        def ascribes(*args, &block)
          has_many(*args, &block)
        end

        def has_property(*args)
          belongs_to(*args)
        end
      end
    end
  end
end
