module Nunchaku
  module MaterialObjectComposition
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        %i()
      end

      def self.build(model, reflection)
        if reflection.options[:association_kind] == MaterialObjectComposition.name.underscore

        end
      end
    end

    included do
      ::ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end

    module ClassMethods
      def is_made_of(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => MaterialObjectComposition.name.underscore)

        has_many(*(args << options), &block)
      end

      def makes_up(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => MaterialObjectComposition.name.underscore)

        belongs_to(*(args << options), &block)
      end
    end
  end
end
