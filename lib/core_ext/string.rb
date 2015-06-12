#encoding: UTF-8
class String
  def hanize
    self.split("").map{|c| c.contains_cjk? ? "#{c}^" : c}.join
  end

  def annotate
    self.size == 1 ? "#{self}^^" : self.split("").map{|c| c == '^' ? c : "#{c}^"}.join
  end

  def contains_cjk?
    !!(self =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/)
  end
end