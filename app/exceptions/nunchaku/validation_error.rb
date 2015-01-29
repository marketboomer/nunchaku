# Note: Defining ValidationError as a nested module caused an exception on call to ValidationError.new
module Nunchaku
  class ValidationError < StandardError
    def initialize(options)
      super("Validation failure for #{options[:object].class.name.titleize} - #{options[:errors].full_messages.join(' ')}")
    end
  end
end
