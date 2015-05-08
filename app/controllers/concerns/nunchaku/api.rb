module Nunchaku
  module Api
    extend ActiveSupport::Concern

    include HashNodeHelper
    include DocumentationHeaderHelper

    included do
      helper 'nunchaku/hash_node'
      helper 'nunchaku/documentation_header'
      helper_method :formatted_resource
    end

    class << self
      def resource_class_name
        super.gsub('::Api', '').singularize
      end
    end

    def show(options = {}, &block)
      if request.format.json?
        respond_with(formatted_resource)
      else
        respond_with(*(with_nesting(resource) << options), &block)
      end
    end

    protected

    def formatted_resource
      @formatted_resource ||= formatter_class(:json).new.output(resource)
    end

    def formatter_class(format)
      "#{resource_class_name.deconstantize}::#{format.to_s.titleize}::#{resource_class_name.demodulize}".safe_constantize
    end
  end
end
