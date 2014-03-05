class Nunchaku::ResourcesController < ActionController::Base
  include Nunchaku::Resources

  AUTOCOMPLETE_LIMIT = 50

  around_filter :transactions_filter, :only => %w(create update)

	helper_method :collection_fields, :decorator_context


  def autocomplete
    if collection.respond_to? :translated_search
      search_scope = collection.translated_search(search_terms)
    else # Assume resource is FullTextSearchable
      search_scope = collection.full_text_search(search_terms)
    end
    respond_with search_scope.limit(AUTOCOMPLETE_LIMIT).map { |a| {:id => a.id, :text => a.to_s } }
  end

  protected

  def transactions_filter
    ActiveRecord::Base.transaction do
      yield
    end
  end

  def collection_fields
    []
  end

  def decorator_context
    nil
  end
end
