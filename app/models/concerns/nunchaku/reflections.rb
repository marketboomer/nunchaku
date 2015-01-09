module Nunchaku
  module Reflections
    extend ActiveSupport::Concern

    module ClassMethods
      def class_for(association)
        reflections[association.to_sym].try(:klass)
      end
    end

    def class_for(association)
      self.class.class_for(association)
    end
  end
end
