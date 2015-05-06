module Nunchaku
  module Attribution
    extend ActiveSupport::Concern

    module ClassMethods
      def ascribes(*args, &block)
        has_many(*args, &block)
      end

      def has_property(*args, &block)
        belongs_to(*args, &block)
      end
    end
  end
end
