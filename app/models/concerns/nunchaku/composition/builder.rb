module Nunchaku
  module Composition
    module Builder
      extend ActiveSupport::Concern

      def valid_options
        super + [ :composition, :association_macro ]
      end
    end
  end
end
