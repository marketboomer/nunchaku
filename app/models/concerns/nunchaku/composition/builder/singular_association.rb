module Nunchaku
  module Composition
    module Builder
      class SingularAssociation < ::ActiveRecord::Associations::Builder::BelongsTo
        include Builder
      end
    end
  end
end
