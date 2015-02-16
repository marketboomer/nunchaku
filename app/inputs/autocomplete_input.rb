class AutocompleteInput < ::SimpleForm::Inputs::StringInput

  def input(*args)
    super << javascript
  end

  protected

  def javascript
    template.javascript_tag(<<-JS.html_safe)
      (function() {
        var input = $("input[type='autocomplete']##{object_name}_#{attribute_name}");

        input.select2({
          placeholder: "#{I18n.t(:search_for, :models => label_text)}",
          minimumInputLength: "#{input_length}" || 3,

          ajax: {
            url: "#{url}",
            dataType: 'json',
            quietMillis: 1000,
            data: function (term) {
              return {
                term: term
              };
            },
            results: function (data) {
              return {results: data};
            }
          }
        });
        if (input.parent().find('span.help-block').length == 0)
          input.parent().find('span.select2-chosen').text(input.attr('hint'));
        else {
          input.parent().find('span.select2-chosen').text(input.parent().find('span.help-block').text());
          input.parent().find('span.help-block').text('');
        }

      })();

    JS
  end

  def input_length
    options[:input_length]
  end

  def url
    options[:url] || "/#{controller}/autocomplete"
  end

  def controller
    object.class.reflect_on_association(association_name).class_name.underscore.pluralize
  end

  def association_name
    attribute_name.to_s.chomp('_id').to_sym
  end
end
