module Nunchaku
  module HashNodeHelper

    def json_tooltip(type, key, value)
      tooltip("data-original-title" => json_key_title(type, key, value)) do
        "\"#{key.to_s}\""
      end
    end

    protected

    def json_key_title(type, key, value)
      [
        t("tooltip.datatype.#{value.class.name.downcase}", :default => '').presence || value.class.name.humanize,
        resource.api_required_attributes.include?(key.to_s) ? t("tooltip.required") : t("tooltip.optional"),
        t("tooltip.#{type.underscore}.#{key}.description", :default => '')
      ].reject {|x| x.blank? }.join(", ")
    end

  end
end
