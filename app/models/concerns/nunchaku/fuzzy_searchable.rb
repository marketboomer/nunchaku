module Nunchaku
  module FuzzySearchable
    extend ActiveSupport::Concern
    include Nunchaku::FuzzySearch

    included do
      before_save :concatenate
    end

    module ClassMethods
      # By default, concatenate text or string values that arent coincatenations, put them in search_text and hanize
      def fuzzy_search_cols
        fuzzy_search_cols_from_hash(columns_hash)
      end

      def fuzzy_search_cols_from_hash col_hash
         col_hash.reject do |k, v|
          %w(search_text locale slug).include?(v.name) || (v.name.split('_').first == 'concatenated') || ![:string, :text].include?(v.type)
        end.map { |k, v| k }
      end

      def fuzzy_search_hanized_cols
        []
      end

      def stop_words
        %w(and are but for not the was will with each 1each 1.0 2.0 3.0 4.0 5.0 6.0 12.0 24.0 box can pack packet carton)
      end

      def search_string(string)
        string.hanize.split(separator).uniq.reject{ |w| stop?(w) }.map { |w| w.size <= 2 ? w.annotate : w }.compact.join(' ')
      end



      def stop?(word)
        (word.size < min_word_length || stop_words.include?(word.downcase)) if !(word =~ /\^/)
      end

      def min_word_length
        3
      end

      def separator
        /[\s\.,-\/#!$%\*;:{}=\-_`~()\?\[\]]/
      end
    end

    def concatenate
      klass = self.class
      return unless klass.attribute_names.include? 'search_text'
      self.search_text = [hanized_search_string, klass.search_string(raw_search_string)].join(' ').strip
    end

    def raw_search_string
      self.class.fuzzy_search_cols.map { |att| send(att).to_s }.join(' ')
    end

    def hanized_search_string
      self.class.fuzzy_search_hanized_cols.map { |att| send(att).to_s }.join(' ')
    end
  end
end