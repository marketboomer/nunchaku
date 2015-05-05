module Nunchaku
  module CompositionAssociations
    extend ActiveSupport::Concern

    include ConfigurationalAssociation
    include HomeomericAssociation
    include InvariantAssociation

    module ClassMethods
      def divides_into(*args, &block)
        options = args.extract_options!
        options.merge!(:configurational => true)

        has_many(*(args << options), &block)
      end

      def is_a_piece_of(*args, &block)
        options = args.extract_options!
        options.merge!(:configurational => true)

        belongs_to(*(args << options), &block)
      end
    end
  end
end
