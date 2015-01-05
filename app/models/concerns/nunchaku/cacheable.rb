module Nunchaku
  module Cacheable
    extend ActiveSupport::Concern

    module ClassMethods
      def with_cache(key, &block)
        Rails.cache.fetch(key) { block.call }
      end

      def clear_cache_for_key(key)
        Rails.cache.delete(key)
      end

      def clear_cache_for_user(user)
        Rails.cache.delete_matched("user#{user.id}_*")
      end

      protected

      def user_cache_key_fragment(user)
        "user#{user.id}_organisation#{user.current_access_organisation.id}"
      end
    end
  end
end
