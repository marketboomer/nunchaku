module Nunchaku
  module Composition
    module Attribution
      extend ActiveSupport::Concern

      module ClassMethods
        def has_attributes(*args, &block)
          has_many(*args, &block)
        end

        def is_attribute_of(*args)
          belongs_to(*args)
        end
      end

      class HasAttributes < Builder::CollectionAssociation
        include Properties::Invariant
      end

      class IsAttributeOf < Builder::SingularAssociation
        include Properties::Invariant
      end

      module ClassMethods
        def has_attributes(name, scope = nil, options = {}, &extension)
          reflection = HasAttributes.build(self, name, scope, options, &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def is_attribute_of(name, scope = nil, options = {})
          reflection = IsAttributeOf.build(self, name, scope, options)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
