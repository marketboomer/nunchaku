module Nunchaku::ResourcesInputHelper
  def simple_form_for(object, options={}, &block)
    options.reverse_merge!  :builder => builder,
                            :url => create_or_update_resource_path(object)

    super(object, options, &block)
  end

  def builder
  	"#{resource_class.name}FormBuilder".constantize

  	rescue NameError => e
      default_builder
  end

  def form_element_names
  	decorator_class.form_element_names
  end

  protected

  def default_builder
    action_name.in?(%w(show)) ? Nunchaku::DisabledFormBuilder : Nunchaku::ResourceFormBuilder
  end
end
