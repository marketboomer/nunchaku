module Nunchaku
  module Composition
    module Properties
      module Invariant
        extend ActiveSupport::Concern

        def initialize(*args)
          super.tap do
            (options[:composition] ||= []) << :invariant

            options[:dependent] = :destroy if macro == :has_many
          end
        end

        def define_extensions(model)
          super.tap do
            model.validates(name, :presence => true) if macro == :belongs_to
          end
        end
      end
    end
  end
end
