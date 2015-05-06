module Nunchaku
  module Attachment
    extend ActiveSupport::Concern

    module ClassMethods
      def has_attachments(*args, &block)
        has_many(*args, &block)
      end

      def attaches_to(*args, &block)
        belongs_to(*args, &block)
      end
    end
  end
end
