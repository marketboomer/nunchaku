module Nunchaku
  module Composition
    module PlaceArea
      extend ActiveSupport::Concern

      class Places < Nunchaku::Composition::Builder::CollectionAssociation
        include Properties::Configurational
        include Properties::Homeomeric
        include Properties::Invariant
      end

      class IsPlacedIn < Nunchaku::Composition::Builder::SingularAssociation
        include Properties::Configurational
        include Properties::Homeomeric
        include Properties::Invariant
      end

      module ClassMethods
        def places(name, scope = nil, options = {}, &extension)
          reflection = Places.build(self, name, scope, options.merge(:association_macro => :places), &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def is_in_the_area_of(name, scope = nil, options = {})
          reflection = IsPlacedIn.build(self, name, scope, options.merge(:association_macro => :is_in_the_area_of))
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
