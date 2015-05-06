module Nunchaku
  module Composition
    module PlaceArea
      # configurational, homeomeric, invariant
      extend ActiveSupport::Concern

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
end
