module Nunchaku
  module Composition
    module MaterialObject
      extend ActiveSupport::Concern

      class HasMaterials < Builder::CollectionAssociation
        include Properties::Configurational
        include Properties::Invariant
      end

      class Makes < Builder::SingularAssociation
        include Properties::Configurational
        include Properties::Invariant
      end

      module ClassMethods
        def has_materials(name, scope = nil, options = {}, &extension)
          reflection = HasMaterials.build(self, name, scope, options, &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def makes(name, scope = nil, options = {})
          reflection = Makes.build(self, name, scope, options)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
