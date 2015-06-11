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
    end
  end
end