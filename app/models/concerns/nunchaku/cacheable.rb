module Nunchaku
  module Cacheable
    extend ActiveSupport::Concern

    module ClassMethods
      def with_cache(key, &block)
        Rails.cache.fetch(key) { block.call }
      end
    end

    def with_cache(*args, &block)
      self.class.with_cache(access_cache_key(*args), &block)
    end

    def access_cache_key(adjective, target_class)
      [
        cache_key,
        adjective,
        target_class.name.underscore
      ].compact.join('_')
    end

    def clear_access_cache
      Rails.cache.delete_matched("#{cache_qualifier}#{id}_*")
    end

    def cache_key
      "#{cache_qualifier}#{id}"
    end

    def cache_qualifier
      self.class.name.demodulize.underscore
    end
  end
end
