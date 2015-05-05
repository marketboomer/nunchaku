module Nunchaku
  module HomeomericAssociation
    extend ActiveSupport::Concern

    module AssociationBuilderExtension
      def self.valid_options
        [ :homeomeric ]
      end

      def self.build(model, reflection)
        if reflection.options[:homeomeric]
          # do stuff
        end
      end
    end

    included do
      ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end
  end
end
