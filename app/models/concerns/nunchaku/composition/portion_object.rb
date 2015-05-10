module Nunchaku
  module Composition
    module PortionObject
      extend ActiveSupport::Concern

      class HasPortionsOf < Builder::CollectionAssociation
        include Properties::Configurational
        include Properties::Homeomeric
      end

      class IsPortionOf < Builder::SingularAssociation
        include Properties::Configurational
        include Properties::Homeomeric
      end

      module ClassMethods
        def has_portions_of(name, scope = nil, options = {}, &extension)
          reflection = HasPortionsOf.build(self, name, scope, options, &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def is_portion_of(name, scope = nil, options = {})
          reflection = IsPortionOf.build(self, name, scope, options)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
