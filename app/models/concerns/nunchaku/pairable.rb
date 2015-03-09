module Nunchaku
  module Pairable
    extend ActiveSupport::Concern

    module ClassMethods
      def to_pairs
        all.map { |a| { :id => a.id, :text => a.to_s } }
      end
    end
  end
end
