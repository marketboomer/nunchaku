class Nunchaku::ResourceFormBuilder < SimpleForm::FormBuilder

  attr_accessor :as_row_form

  def just_some_text(key)
    template.label_tag t(key)
  end

  def t(key)
    template.t("form.#{object.class.name.underscore}.#{key}")
  end

  def association(*args)
  	options = args.extract_options!

		super(args.first,
      {
        :as => :enhanced_select,
        :placeholder => "Select a #{object.class.model_name.human}",
        :label_method => :to_s,
        :required => true,
        :include_blank => false
      }.merge(options)
	  )
  end

  def edit
  end

  def save
    submit :class => 'btn btn-xs btn-info submit'
  end

  def actions
    template.render :partial => 'form_actions',
                    :locals => { :f => self }
  end

  def deletable?
    object.persisted?
  end

  def input(*args)
    as_row_form ? input_field(*args) : super
  end

  def method_missing(method, *args, &block)
    if object.respond_to?(method)
      input method
    else
      super
    end
  end
end
