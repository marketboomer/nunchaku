module Nunchaku::FuzzySearchable
  extend ActiveSupport::Concern
  include Nunchaku::FuzzySearch

  included do
    before_save :concatenate
  end

  module ClassMethods
    # By default, concatenate text or string values that arent coincatenations, put them in search_text and hanize
    def fuzzy_search_cols
      columns_hash.reject do |k,v|
        %w(search_text locale slug).include?(v.name) || (v.name.split('_').first == 'concatenated') || ![:string, :text].include?(v.type)
      end.map { |k,v| k }
    end

    def stop_words
      %w(and are but for not the was will with each 1each 1.0 2.0 3.0 4.0 5.0 6.0 12.0 24.0 box can pack packet carton)
    end

    def search_string string
      string.hanize.split(separator).uniq.reject{ |w| stop?(w) }.first(8).join(' ')
    end

    def stop? word
      word.size < 3 || stop_words.include?(word)
    end

    def separator
      /[\s\.,-\/#!$%\*;:{}=\-_`~()\?\[\]]/
    end
  end

  def concatenate
    klass = self.class
    return unless klass.attribute_names.include? 'search_text'
    self.search_text = klass.search_string(klass.fuzzy_search_cols.map { |att| send(att).to_s }.join(' '))
  end

end