class RoundedNumericInput < ::SimpleForm::Inputs::NumericInput
  def input(*args)
    input_html_classes.unshift('form-control')
    input_html_options.merge! :value => object.send(attribute_name).round(2)

    super(*args)
  end
end
