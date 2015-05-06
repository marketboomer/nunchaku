module Nunchaku
  module ComponentIntegralComposition
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        %i()
      end

      def self.build(model, reflection)
        if reflection.options[:association_kind] == ComponentIntegralComposition.name.underscore
          model.validates reflection.name, :presence => true
        end
      end
    end

    included do
      ::ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end

    module ClassMethods
      def has_components(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => ComponentIntegralComposition.name.underscore)

        has_many(*(args << options),  &block)
      end

      def is_component_of(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => ComponentIntegralComposition.name.underscore)

        belongs_to(*(args << options), &block)
      end
    end
  end
end
