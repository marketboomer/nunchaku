module Nunchaku
  module Nameable
    extend ActiveSupport::Concern

    included do
      validates :name,
                length: { :maximum => 255 },
                presence: true
    end

    def to_s
      name.presence || name_was.presence || "a #{self.class.model_name.human}"
    end
  end
end
