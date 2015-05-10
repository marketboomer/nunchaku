module Nunchaku
  module Composition
    module Properties
      module Configurational
        extend ActiveSupport::Concern

        def initialize(*args)
          super.tap do
            (@options[:composition] ||= []) << :configurational
          end
        end
      end
    end
  end
end
