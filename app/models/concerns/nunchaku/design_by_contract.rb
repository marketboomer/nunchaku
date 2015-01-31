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

    def require_pre(*args)
      assert_clauses('precondition', *args)
    end

    def ensure_post(*args)
      assert_clauses('postcondition', *args)
    end

    def assert_clauses(assertion_type, method, clauses, args={})
      log_now "Asserting #{assertion_type} for #{self.object_id} #{self.class.name}##{method}: #{self}", :info

      ae = assertion_eval(clauses, args)

      if ae.values.include?(false)
        log_clause_failure(clauses, args, ae)

        raise AssertionError.new(self), assertion_type
      end
    end

    def assert_invariant
      log_now "Asserting invariant for #{self.object_id} #{self.class.name}: #{self}", :info

      if invariant_fails?
        log_invariant_failure

        raise AssertionError.new(self), 'invariant fails'
      end
    end

    def assertions
      {}
    end

    def clauses_for(clause_names)
      assertions.select { |k,v| [clause_names].flatten.include?(k) }
    end

    def invariant
      {}
    end

    private

    def reset_eval
      @invariant_eval = nil
    end

    def assertion_eval(clauses, args)
      clauses.
        map { |k, v| [k, v.call(self, args)] }.
        to_h
    end

    def invariant_eval
      @invariant_eval ||= invariant.
        map { |k, v| [k, v.call(self)] }.
        to_h

      log_now @invariant_eval.to_yaml, :debug

      @invariant_eval
    end

    def assertion_eval(clause_names, args)
      clauses_for(clause_names).
        map { |k, v| [k, v.call(self, args)] }.
        to_h
    end

    def log_invariant_failure
      invariant_eval.
        reject { |k, v| v }.
        each { |k, v| log_failure(invariant, k) }

      log_now to_yaml
    end

    def log_clause_failure(clause_names, args, evald_clauses)
      evald_clauses.
        reject { |k, v| v }.
        each { |k, v| log_failure(assertions, k) }

      log_now "Input arguments #{args.to_yaml}"
      log_now to_yaml
    end

    def log_failure(clauses, key)
      log_now I18n.t("#{self.class.name.underscore}.assertion.fail.#{key}")
      log_now "in #{clauses[key].source_location.join(':')}"
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
