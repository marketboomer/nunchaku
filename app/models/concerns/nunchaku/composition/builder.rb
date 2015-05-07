module Nunchaku
  module Composition
    module Builder
      extend ActiveSupport::Concern

      module ClassMethods
        def valid_options
          super + [ :composition ]
        end
      end
    end
  end
end