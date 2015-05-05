#encoding: UTF-8
class String
  def hanize
    self.contains_cjk? ? self.annotate : self
  end

  def annotate(separator = '^')
    self.split("").join(separator) << separator
  end

  def contains_cjk?
    !!(self =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/)
  end
end