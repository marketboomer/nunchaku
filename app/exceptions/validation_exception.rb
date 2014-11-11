module Nunchaku
  class ValidationException < StandardError
    def initialize(options)
      super("Validation failure for #{options[:object].class.name.titleize} - #{options[:errors].full_messages.join(' ')}")
    end
  end
end