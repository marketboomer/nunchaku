module Nunchaku
  module Composition
    module PlaceArea
      extend ActiveSupport::Concern

      class Places < Builder::CollectionAssociation
        include Properties::Configurational
        include Properties::Homeomeric
        include Properties::Invariant
      end

      class IsPlacedIn < Builder::SingularAssociation
        include Properties::Configurational
        include Properties::Homeomeric
        include Properties::Invariant
      end

      module ClassMethods
        def places(name, scope = nil, options = {}, &extension)
          reflection = Places.build(self, name, scope, options, &extension)
          Reflection.add_reflection(self, name, reflection)
        end

        def is_placed_in(name, scope = nil, options = {})
          reflection = IsPlacedIn.build(self, name, scope, options)
          Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
