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

      class HasAttributes < Nunchaku::Composition::Builder::CollectionAssociation
        include Properties::Invariant
      end

      class IsAttributeOf < Nunchaku::Composition::Builder::SingularAssociation
        include Properties::Invariant
      end

      module ClassMethods
        def has_attributes(name, scope = nil, options = {}, &extension)
          reflection = HasAttributes.build(self, name, scope, options.merge(:association_macro => :has_attributes), &extension)
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end

        def is_attribute_of(name, scope = nil, options = {})
          reflection = IsAttributeOf.build(self, name, scope, options.merge(:association_macro => :is_attribute_of))
          ::ActiveRecord::Reflection.add_reflection(self, name, reflection)
        end
      end
    end
  end
end
