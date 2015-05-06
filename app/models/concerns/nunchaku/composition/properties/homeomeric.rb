module Nunchaku
  module Composition
    module Properties
      module Homeomeric
        extend ActiveSupport::Concern

        def initialize(*args)
          super.tap do
            (@options[:composition] ||= []) << :homeomeric
          end
        end
      end
    end
  end
end
