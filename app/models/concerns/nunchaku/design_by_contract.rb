module Nunchaku
  module DesignByContract
    extend ActiveSupport::Concern

    def invariant_passes?
      !invariant_fails?
    end

    def invariant_fails?
      invariant_eval.values.include?(false)
    end

    protected

    def require_pre(args, clauses)
    end

    def ensure_post(args, clauses)
    end

    def assert_invariant(level=:warn)
      log_now "Asserting invariant for  #{self.object_id} #{self.class.name}: #{self}", :info

      if invariant_fails?
        log_invariant_failure(level)

        raise AssertionError.new(self), 'invariant fails'
      end
    end

    def invariant
      {}
    end

    private

    def reset_eval
      @invariant_eval = nil
    end

    def invariant_eval
      @invariant_eval ||= invariant.map { |k, v| [k, v.call(self)] }.to_h

      log_now @invariant_eval.to_yaml, :debug

      @invariant_eval
    end

    def assertion_eval(clauses, args)
      clauses.map { |k, v| [k, v.call(self, args)] }.to_h
    end

    def log_invariant_failure
      invariant_eval.reject { |k, v| v }.each do |k, v|
        log_failure(invariant, key)
      end

      log_now to_yaml
    end

    def log_clause_failure(clauses, args, evald_clauses)
      evald_clauses.reject { |k, v| v }.each do |k, v|
        log_failure(clauses, key)
      end

      log_now "Input arguments #{args.to_yaml}"

      log_now to_yaml
    end

    def log_failure(clauses, key)
      log_now I18n.t("#{self.class.name.underscore}.assertion.fail.#{k}")

      log_now "in #{clauses[k].source_location.join(':')}"
    end

    def log_now(text, level=:warn)
      logger.send(level) { ' ' * 4 + text }
    end
  end

  class AssertionError < StandardError
    attr_reader :resource

    delegate :invariant, :to => :@resource

    def initialize(resource)
      @resource = resource
    end
  end
end
