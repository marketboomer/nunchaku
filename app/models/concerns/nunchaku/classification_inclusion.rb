module Nunchaku
  module ClassificationInclusion
    extend ActiveSupport::Concern

    module ClassMethods
      def classifies(*args, &block)
        has_many(*args, &block)
      end

      def is_classified_by(*args, &block)
        belongs_to(*args, &block)
      end
    end
  end
end
