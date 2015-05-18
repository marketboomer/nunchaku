module Nunchaku
  module DocumentationHeaderHelper

    protected

    def documentation(section)
      r = simple_format(t("api_documentation.#{params[:controller]}.#{section}"))
      r unless r.empty?
    end
  end
end
