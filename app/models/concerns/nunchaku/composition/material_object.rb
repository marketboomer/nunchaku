module Nunchaku
  module Composition
    module MaterialObject
      extend ActiveSupport::Concern

      class IsMadeOf < Builder::CollectionAssociation
        include Properties::Configurational
        include Properties::Invariant
      end

      class MakesUp < Builder::SingularAssociation
        include Properties::Configurational
        include Properties::Invariant
      end

      module ClassMethods
        def is_made_of(name, scope = nil, options = {}, &extension)
          reflection = IsMadeOf.build(self, name, scope, options, &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def makes_up(name, scope = nil, options = {})
          reflection = MakesUp.build(self, name, scope, options)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
