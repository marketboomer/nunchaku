module Nunchaku
  module InvariantAssociation
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        [ :invariant ]
      end

      def self.build(model, reflection)
        if reflection.options[:invariant]
          # do stuff
        end
      end
    end

    included do
      ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end
  end
end
