module Nunchaku
  module DesignByContract
    extend ActiveSupport::Concern

    def assert_invariant
      !(invariant.values.map { |v| v.call(self) }.include?(false))
    end

    protected

    def invariant
      {}
    end
  end
end
