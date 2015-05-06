module Nunchaku
  module MemberBunchComposition
    extend ActiveSupport::Concern

    module ClassMethods
      def bunches(*args, &block)
        has_many(*args, &block)
      end

      def is_member_in(*args, &block)
        belongs_to(*args, &block)
      end
    end
  end
end
