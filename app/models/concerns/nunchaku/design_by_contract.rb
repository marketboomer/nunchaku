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
    end

    def assertion_eval(clauses, args)
      clauses.map { |k, v| [k, v.call(self, args)] }.to_h
    end

    def log_invariant_failure(level=:warn)
      invariant_eval.reject { |k, v| v }.each do |k, v|
        log_failure(invariant, key, level=:warn)
      end

      logger.send(level) { ' ' * 4 + inspect }
    end

    def log_clause_failure(clauses, args, evald_clauses, level=:warn)
      evald_clauses.reject { |k, v| v }.each do |k, v|
        log_failure(clauses, key, level=:warn)
      end

      logger.send(level) { ' ' * 4 + 'Input arguments' + args.inspect }
      logger.send(level) { ' ' * 4 + inspect }
    end

    def log_failure(clauses, key, level=:warn)
      logger.send(level) { ' ' * 4 + I18n.t("#{self.class.name.underscore}.assertion.fail.#{k}") }
      logger.send(level) { ' ' * 4 + "in #{clauses[k].source_location.join(':')}" }
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
