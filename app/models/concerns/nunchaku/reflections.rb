module Nunchaku
  module Reflections
    extend ActiveSupport::Concern

    module ClassMethods
      def class_for(association)
        (reflections[association.to_sym] || reflections_from_acting_as[association.to_sym]).try(:klass)
      end

      def resource_type_with_ancestors
        ancestors.select { |c| c.ancestors.include?(::ActiveRecord::Base) }.reject { |c| c.abstract_class? || c == ::ActiveRecord::Base }
      end

      protected

      def reflections_from_acting_as
        acting_as_model.reflections if acting_as?
      end
    end

    def class_for(association)
      self.class.class_for(association)
    end
  end
end
