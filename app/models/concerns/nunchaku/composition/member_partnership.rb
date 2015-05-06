module Nunchaku
  module Composition
    module MemberPartnership
      extend ActiveSupport::Concern

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
end
