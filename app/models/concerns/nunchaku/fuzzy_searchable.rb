module Nunchaku::FuzzySearchable
  extend ActiveSupport::Concern

  included do
    before_save :concatenate
  end

  SQL_REGEX = /(([a-z0-9._]+)\s([asc|desc]+)|[a-z0-9._]+)/i

  module ClassMethods

    def fuzzy_search terms, opts = {}
      return all if terms.blank?
      col = opts[:column] || 'search_text'
      where(terms.map { |term| "#{table_name}.#{col} ILIKE ?" }.join(' AND '), *(terms.map { |t| "%#{t}%" }))
    end

    def ordered_search terms, opts = {}
      sort, order, default_sort = opts[:sort], opts[:order], opts[:default_sort]
      select_clause(sort, default_sort)
      .fuzzy_search(terms, opts)
      .order_clause(sort, order, default_sort)
    end

    def select_clause(sort, default_sort)
      all_targets = ["#{self.table_name}.*", order_targets(sort)] + default_targets(default_sort)
      select all_targets.reject(&:blank?).join(',')
    end

    def order_targets field
      field unless attribute_names.include?(field) # Will return nil otherwise since its already included
    end

    def order_clause(field, order='asc', default_sort=nil)
      return all if field.blank? && default_sort.blank?
      return default_order_clause(default_sort) if field.blank?
      return order("#{field} #{order}") if order_targets(field).blank?
      ord_join = " #{order},"
      order("#{order_targets(field).split(',').join(ord_join)} #{order}")
    end

    def default_order_clause default_sort
      default_sort.blank? ? all : order(default_sort)
    end

    def default_targets default_sort
      default_sort.to_s.split(/,/).map do |order_string|
        m = order_string.match(SQL_REGEX)
        m[2] || m[1] if m
      end.compact.reject { |c| attribute_names.include?(c) }
    end

    # By default, concatenate text or string values that arent coincatenations, put them in search_text and hanize
    def fuzzy_search_cols
      columns_hash.reject do |k,v|
        %w(search_text locale slug).include?(v.name) || (v.name.split('_').first == 'concatenated') || ![:string, :text].include?(v.type)
      end.map { |k,v| k }
    end

    def stop_words
      []
    end
  end

  def concatenate
    return unless self.class.attribute_names.include? 'search_text'
    self.search_text = self.class.fuzzy_search_cols.map { |att| send(att).to_s.hanize.split(' ') }.flatten.uniq.reject{ |w| stop?(w) }.join(' ')
  end

  def stop? word
    word.size < 3 || self.class.stop_words.include?(word)
  end

end