module Nunchaku
  module Composition
    module MemberPartnership
      extend ActiveSupport::Concern

      class DividesInto < Builder::CollectionAssociation
        include Properties::Invariant
      end

      class IsPieceOf < Builder::SingularAssociation
        include Properties::Invariant
      end

      module ClassMethods
        def divides_into(name, scope = nil, options = {}, &extension)
          reflection = DividesInto.build(self, name, scope, options, &extension)
          Reflection.add_reflection(self, name, reflection)
        end

        def is_piece_of(name, scope = nil, options = {})
          reflection = IsPieceOf.build(self, name, scope, options)
          Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
