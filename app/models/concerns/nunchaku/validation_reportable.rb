module Nunchaku
  module ValidationReportable
    require 'new_relic/agent'
    extend ActiveSupport::Concern

    included do
      after_validation :report_errors, :if => proc { |model| model.errors.present? }
    end

    protected

    def report_errors
      e = Nunchaku::ValidationError.new({:object => self, :errors => errors})
      NewRelic::Agent.notice_error(e.message) if newrelic_started?
      raise e
    end

    private

    def newrelic_started?
      return false if Rails.env.development? || Rails.env.test?
      begin
        NewRelic::Agent.agent
        true
      rescue
        false
      end if defined?(NewRelic)
    end
  end
end