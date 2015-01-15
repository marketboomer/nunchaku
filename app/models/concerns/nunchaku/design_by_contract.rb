module Nunchaku
  module DesignByContract
    extend ActiveSupport::Concern

    def assert_invariant
      if invariant_fails?
        log_invariant_failure
        raise AssertionError.new(self), 'invariant fails'
      end
    end

    def invariant_passes?
      !invariant_fails?
    end

    def invariant_fails?
      invariant_eval.values.include?(false)
    end

    protected

    def invariant
      {}
    end

    def log_invariant_failure
      invariant_eval.reject { |k, v| v }.each do |k, v|
        logger.fatal { I18n.t("#{self.class.name.underscore}.invariant.fail.#{k}") }
        logger.fatal { "in #{invariant[k].source_location.join(':')}" }
      end
    end

    def invariant_eval
      @invariant_eval ||= invariant.map { |k, v| [k, v.call(self)] }.to_h
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
