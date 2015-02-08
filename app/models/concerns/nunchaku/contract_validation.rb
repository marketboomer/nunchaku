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
      
      log_now error_sentence, :debug
    end

    def assert_clauses(assertion_type, method, clauses, args={})
      log_now "Asserting #{assertion_type} for #{self.object_id} #{self.class.name}##{method}: #{self}", :info

      ae = assertion_eval(clauses, args)

      log_now ae.to_yaml, :debug
      
      add_clause_errors(ae) if ae.values.include?(false)
    end

    private

    def add_invariant_errors
      invariant_eval.reject { |k, v| v }.each do |k, v|
        errors[:base] << (I18n.t("#{self.class.name.underscore}.invariant.fail.#{k}"))
      end

      log_now error_sentence, :debug
    end

    def add_clause_errors(assertions_eval)
      assertions_eval.reject { |k, v| v }.each do |k, v|
        errors[:base] << (I18n.t("#{self.class.name.underscore}.assertion.fail.#{k}"))
      end

      log_now error_sentence, :debug
    end
  end
end
