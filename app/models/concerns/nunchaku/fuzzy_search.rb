module Nunchaku
  module FuzzySearch
    extend ActiveSupport::Concern

    SQL_REGEX = /(([a-z0-9._]+)\s([asc|desc]+)|[a-z0-9._]+)/i

    module ClassMethods

      def fuzzy_search(terms, opts = {})
        return all if terms.blank?
        col = search_column(opts)
        where(terms.map { |term| "#{fuzzy_search_table(col)}.#{col} ILIKE ?" }.join(' AND '), *(terms.map { |t| "%#{t}%" }))
      end

      def ordered_search(terms, opts = {})
        sort, order, default_sort = opts[:sort], opts[:order], opts[:default_sort]
        select_clause(sort, default_sort)
        .fuzzy_search(terms, opts)
        .order_clause(sort, order, default_sort)
      end

      def select_clause(sort, default_sort)
        all_targets = select_fields + [order_targets(sort)] + default_targets(default_sort)
        select all_targets.reject(&:blank?).join(',')
      end

      def select_fields
        ["#{self.table_name}.*"]
      end

      def order_targets(field)
        field unless attribute_names.include?(field) # Will return nil otherwise since its already included
      end

      def order_clause(field, order='asc', default_sort=nil)
        return all if field.blank? && default_sort.blank?
        return default_order_clause(default_sort) if field.blank?
        return order("#{field} #{order}") if order_targets(field).blank?
        ord_join = " #{order},"
        order("#{order_targets(field).split(',').join(ord_join)} #{order}")
      end

      def default_order_clause(default_sort)
        default_sort.blank? ? all : order(default_sort)
      end

      def default_targets(default_sort)
        default_sort.to_s.split(/,/).map do |order_string|
          m = order_string.match(SQL_REGEX)
          m[2] || m[1] if m
        end.compact.reject { |c| attribute_names.include?(c) }
      end

      def fuzzy_search_table(col)
        table_name
      end

      def search_column(opts)
        puts "search_column"
        opts[:column] || 'search_text'
      end
    end
  end
end