module Nunchaku
  module InlineInputs
    class Autocomplete < Base

      def config
        super.merge({:type => 'select2'})
      end

      def javascript
        template.javascript_tag(<<-JS.html_safe)
        (function() {
          var input = $("#edit_#{attr_name}");

          input.editable({
            params: function(params) {
              params['_method'] = 'put';
              params["#{self.options[:resource]}[" + params.name + "]"] = params.value;
              return params;
            },
            select2: {
              placeholder: "#{placeholder}",
              minimumInputLength: 2,
              ajax: {
                url: "#{self.options[:source]}",
                dataType: 'json',
                quietMillis: 1000,
                data: function (term) {
                  return {
                    term: term,
                    autocomplete_filters: window.nunchaku.autocomplete_filters
                  };
                },
                results: function (data) {
                  return {results: data};
                }
              }
            }
          });
        })();
        JS
      end

      protected

      def placeholder
        association ?  translated_model : I18n.t(attr_name)
      end

      def translated_model
        I18n.t(:search_for, :models => resource.class.human_attribute_name(association.name.to_s))
      end

      def association
        @association ||= resource.class.reflect_on_all_associations(:belongs_to).uniq(&:foreign_key).select {|a| a.foreign_key.to_s == attr_name.to_s}.first
      end
    end
  end
end
