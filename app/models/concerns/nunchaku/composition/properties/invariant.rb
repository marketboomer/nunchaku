module Nunchaku
  module Composition
    module Properties
      module Invariant
        extend ActiveSupport::Concern

        def initialize(*args)
          super.tap do
            (options[:composition] ||= []) << :invariant
          end
        end

        def define_extensions(model)
          super.tap do
            model.validates(name, :presence => true)
          end
        end
      end
    end
  end
end
