module Nunchaku
  module DocumentationHeaderHelper

    protected

    def translation_namespace
      "#{resource_class.to_s.deconstantize.underscore}\/#{resource_class.to_s.demodulize.underscore}"
    end

    def documentation(section)
      r = t("api_documentation.#{translation_namespace}.#{section}")
      r unless r.empty?
    end
  end
end
