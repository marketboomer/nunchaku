module Nunchaku
  module DocumentationHeaderHelper

    protected

    def documentation(section)
      r = t("api_documentation.#{params[:controller]}#{params[:type]}.#{section}")
      r unless r.empty?
    end
  end
end
