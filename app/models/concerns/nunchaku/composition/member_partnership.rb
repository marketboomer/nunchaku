module Nunchaku
  module Composition
    module MemberPartnership
      extend ActiveSupport::Concern

      class Partners < Builder::CollectionAssociation
        include Properties::Invariant
      end

      class IsPartnerIn < Builder::SingularAssociation
        include Properties::Invariant
      end

      module ClassMethods
        def partners(name, scope = nil, options = {}, &extension)
          reflection = Partners.build(self, name, scope, options, &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def is_partner_in(name, scope = nil, options = {})
          reflection = IsPartnerIn.build(self, name, scope, options)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
