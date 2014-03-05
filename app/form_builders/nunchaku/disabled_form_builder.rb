class Nunchaku::DisabledFormBuilder < SimpleForm::FormBuilder

  def actions
  end

  (field_helpers - [:label]).each do |selector|
    src = <<-END_SRC
      def #{selector}(field, options = {})
        super field, { disabled: true }.merge(options)
      end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end
end
