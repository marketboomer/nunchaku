module Nunchaku
  module Autocompleting
    extend ActiveSupport::Concern

    AUTOCOMPLETE_LIMIT = 50

    def autocomplete
      respond_with autocomplete_collection.limit(AUTOCOMPLETE_LIMIT).to_pairs
    end

    protected

    def autocomplete_collection
      collection_translated_or_else_fuzzy
    end

    def collection_translated_or_else_fuzzy
      collection.send (collection.respond_to?(:translated_search) ? :translated_search : :fuzzy_search), search_terms
    end

    def autocomplete?
      controller.action_name == 'autocomplete'
    end
  end
end
