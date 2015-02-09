module Nunchaku
  module Blacklisted
    extend ActiveSupport::Concern

    included do
      scope :blacklist, -> { where(:blacklisted => true) }
      scope :whitelist, -> { where(:blacklisted => false) }
    end
  end
end
