module Nunchaku
  module PlaceAreaComposition
    # configurational, homeomeric, invariant
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        %i()
      end

      def self.build(model, reflection)
        if reflection.options[:association_kind] == PlaceAreaComposition.name.underscore
          # model.validates reflection.name, :presence => true
        end
      end
    end

    module ClassMethods
      def places(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => PlaceAreaComposition.name.underscore)

        has_many(*(args << options), &block)
      end

      def is_placed_in(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => PlaceAreaComposition.name.underscore)

        options.merge!(:configurational => true, :homeomeric => true, :invariant => true)
      end
    end
  end
end
