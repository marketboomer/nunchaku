module Nunchaku::Translated
  extend ActiveSupport::Concern
  include Nunchaku::FuzzySearched

  protected

  def build_resource(*args)
    memoize_resource do
      super.tap do |r|
        r.locale = I18n.locale
      end
    end
  end
end