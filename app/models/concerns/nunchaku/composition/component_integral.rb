module Nunchaku
  module Composition
    module ComponentIntegral
      extend ActiveSupport::Concern

      class Integrates < Nunchaku::Composition::Builder::CollectionAssociation
        include Properties::Configurational
      end

      class IsComponentOf < Nunchaku::Composition::Builder::SingularAssociation
        include Properties::Configurational
      end

      module ClassMethods
        def integrates(name, scope = nil, options = {}, &extension)
          reflection = Integrates.build(self, name, scope, options.merge(:association_macro => :integrates), &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def is_component_of(name, scope = nil, options = {})
          reflection = IsComponentOf.build(self, name, scope, options.merge(:association_macro => :is_component_of))
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
