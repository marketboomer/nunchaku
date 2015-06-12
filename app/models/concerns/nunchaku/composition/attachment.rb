module Nunchaku
  module Composition
    module Attachment
      extend ActiveSupport::Concern

      module ClassMethods
        def has_attachments(*args, &block)
          has_many(*args, &block)
        end

        def attaches_to(*args)
          belongs_to(*args)
        end
      end
    end
  end
end
