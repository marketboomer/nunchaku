module Nunchaku
  module Composition
    module Builder
      class CollectionAssociation < ::ActiveRecord::Associations::Builder::HasMany
        include Builder
      end
    end
  end
end
