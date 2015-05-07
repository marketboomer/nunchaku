module Nunchaku
  module Composition
    module TopologicalInclusion
      extend ActiveSupport::Concern

      module ClassMethods
        def encompasses(*args, &block)
          has_many(*args, &block)
        end

        def is_in(*args, &block)
          belongs_to(*args, &block)
        end
      end
    end
  end
end
