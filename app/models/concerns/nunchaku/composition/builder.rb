module Nunchaku
  module Composition
    module Builder
      extend ActiveSupport::Concern

      module ClassMethods
        def valid_options
          super + [ :composition ]
        end
      end

      def build(model)
        Reflection.new(macro, name, scope, options, model)
      end
    end
  end
end
