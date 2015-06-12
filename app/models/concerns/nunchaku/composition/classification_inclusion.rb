module Nunchaku
  module Composition
    module ClassificationInclusion
      extend ActiveSupport::Concern

      module ClassMethods
        def classifies(*args, &block)
          has_many(*args, &block)
        end

        def is_classified_by(*args)
          belongs_to(*args)
        end
      end
    end
  end
end
