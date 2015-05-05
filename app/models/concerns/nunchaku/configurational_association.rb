module Nunchaku
  module ConfigurationalAssociation
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        [ :configurational ]
      end

      def self.build(model, reflection)
        if reflection.options[:configurational]
          # do stuff
        end
      end
    end

    included do
      ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end
  end
end
