module Nunchaku
  module Composition
    module Reflection
      extend ActiveSupport::Concern

      def composition
        @composition ||=
          Array(options[:composition].presence).flatten
      end

      def configurational?
        composition.include?(:configurational)
      end

      def homeomeric?
        composition.include?(:homeomeric)
      end

      def invariant?
        composition.include?(:invariant)
      end
    end
  end
end
