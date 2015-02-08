module Nunchaku
  module Chainable
    extend ActiveSupport::Concern

    included do
      belongs_to  :predecessor, class_name: self.name, inverse_of: :successor

      has_one     :successor, class_name: self.name, inverse_of: :predecessor, foreign_key: :predecessor_id
    end
  end
end
