module Nunchaku
  module Composition
    module ComponentIntegral
      extend ActiveSupport::Concern

      class HasComponents < Builder::CollectionAssociation
        include Properties::Configurational
      end

      class IsComponentOf < Builder::SingularAssociation
        include Properties::Configurational
      end

      module ClassMethods
        def has_components(name, scope = nil, options = {}, &extension)
          reflection = HasComponents.build(self, name, scope, options, &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def is_component_of(name, scope = nil, options = {})
          reflection = IsComponentOf.build(self, name, scope, options)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
