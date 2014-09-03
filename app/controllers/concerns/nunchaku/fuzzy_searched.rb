module Nunchaku::FuzzySearched

  extend ActiveSupport::Concern

  protected

  def sort_params
    {}
  end

  def distinct_params
    { :distinct => false }
  end

  # Process sort params from sorted gem
  def sort_column sort_params
    term = sort_params.to_s.downcase.split('!').first
    bits = term.to_s.split('_')
    term = bits[0..-2].join('_') if bits.last.in? ['asc','desc']
    term
  end

  def order_term sort_params
    term = sort_params.to_s.downcase.split('!').first
    term = term.to_s.split('_').last
    term if term.in? ['asc','desc']
  end

  def search_param
    :term
  end

  def search_terms
    params[search_param].blank? ? [] : params[search_param].split(' ').map(&:hanize).uniq.reject{ |t| stop?(t) }
  end

  def stop? word
    word.size < 3 || stop_words.include?(word)
  end

  def stop_words
    resource_class.stop_words
  end

end