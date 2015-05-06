module Nunchaku
  module MemberPartnershipComposition
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        %i()
      end

      def self.build(model, reflection)
        if reflection.options[:association_kind] == MemberPartnershipComposition.name.underscore

        end
      end
    end

    included do
      ::ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end

    module ClassMethods
      def divides_into(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => MemberPartnershipComposition.name.underscore)

        has_many(*(args << options), &block)
      end

      def is_a_piece_of(*args, &block)
        options = args.extract_options!
        options.merge!(:association_kind => MemberPartnershipComposition.name.underscore)

        belongs_to(*(args << options), &block)
      end
    end
  end
end
