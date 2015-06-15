class RoundedNumericInput < ::SimpleForm::Inputs::NumericInput
  def input(*args)
    input_html_classes.unshift('form-control')
    input_html_options.merge! :value => object.send(attribute_name).to_f.round(2) unless input_html_options.has_key?(:value)

    super(*args)
  end
end
