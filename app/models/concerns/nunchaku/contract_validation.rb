module Nunchaku
  module ContractValidation
    extend ActiveSupport::Concern
    include DesignByContract

    included do
      validate :assert_invariant
    end

    def error_sentence
      errors.full_messages.to_sentence
    end
    
    protected

    def assert_invariant
      super
    rescue
      add_invariant_errors
    end

    def add_invariant_errors
      invariant_eval.reject { |k, v| v }.each do |k, v|
        errors[:base] << (I18n.t("#{self.class.name.underscore}.invariant.fail.#{k}"))
      end
    end
  end
end
