module Nunchaku
  module Composition
    module TopologicalInclusion
      extend ActiveSupport::Concern

      module ClassMethods
        def encompasses(*args, &block)
          has_many(*args, &block)
        end

        def is_in(*args)
          belongs_to(*args)
        end
      end
    end
  end
end
