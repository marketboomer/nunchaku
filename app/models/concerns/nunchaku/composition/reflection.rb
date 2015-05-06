module Nunchaku
  module Composition
    class Reflection < ::ActiveRecord::Reflection::AssociationReflection
      def self.add_reflection(*args)
        ::ActiveRecord::Reflection.add_reflection(*args)
      end

      def configurational?
        options[:composition].include?(:configurational)
      end

      def homeomeric?
        options[:composition].include?(:homeomeric)
      end

      def invariant?
        options[:composition].include?(:invariant)
      end
    end
  end
end
