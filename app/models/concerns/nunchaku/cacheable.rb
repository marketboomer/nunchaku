module Nunchaku
  module Cacheable
    extend ActiveSupport::Concern

    module ClassMethods
      def with_cache(key, &block)
        Rails.cache.fetch(key) { block.call }
      end

      protected

      def user_cache_key_fragment(user)
        "user#{user.id}_organisation#{user.current_access_organisation.try(:id)}"
      end
    end
  end
end
