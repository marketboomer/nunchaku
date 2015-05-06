module Nunchaku
  module PortionObjectComposition
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        %i()
      end

      def self.build(model, reflection)
        if reflection.options[:association_kind] == PortionObjectComposition.name.underscore

        end
      end
    end

    module ClassMethods
      def has_portions(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => PortionObjectComposition.name.underscore)

        has_many(*(args << options), &block)
      end

      def is_portion_of(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => PortionObjectComposition.name.underscore)

        belongs_to(*(args << options), &block)
      end
    end
  end
end
