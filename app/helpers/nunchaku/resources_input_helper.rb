module Nunchaku::ResourcesInputHelper
  def simple_form_for(object, options={}, &block)
    options.reverse_merge!  :builder => builder,
                            :url => create_or_update_resource_path(object, options[:without_nesting])

    super(object, options, &block)
  end

  def builder
    builder_class_for(resource_class.name)
  end

  def builder_class_for(name)
    "#{name}FormBuilder".constantize

    rescue NameError => e
      default_builder
  end

  def builder_for(name)
    builder_class_for(name).new(name.demodulize.underscore.to_sym, name.safe_constantize.new, self, {})
  end

  def form_element_names
  	decorator_class.form_element_names
  end

  def form_options
    decorator_class.try(:form_options)
  end

  def with_edit(resource, attr_name, options={}, &block)
    options.reverse_merge!(
      :behaviour => 'editable',
      :name => attr_name,
      :resource => resource_params_name,
      :type => 'text',
      :pk => resource.id,
      :url => resource_path(resource),
      :mode => 'inline',
      :'original-title' => "Edit #{attr_name.to_s.humanize}"
    )

    link_text = block_given? ? yield : editable_link_text(resource, attr_name, options)

    # X-editable doesn't support booleans out of the box, this is the suggested way to represent them
    options.merge!(
        :type => :select,
        :source => [{ value: 1, text: I18n.t(:yes) }, { value: 0, text: I18n.t(:no)}],
        :value => resource.send(attr_name) ? 1 : 0) if options[:type] == :boolean


    link_to link_text, '#', :data => options
  end

  def supported_languages_source
    APP_CONFIG['supported_languages'].keys.map {|l| {:value => l, :text => APP_CONFIG['supported_languages'][l]}}
  end

  def time_zone_source
    ActiveSupport::TimeZone.all.map {|z| {:value => z.name, :text => z.to_s}}
  end

  protected

  def editable_link_text(resource, attr_name, options)
    unless options[:type] == :boolean
      resource.send(attr_name)
    else
      resource.send(attr_name) ? I18n.t(:yes) : I18n.t(:no)
    end
  end

  def form_heading(action)
    t("form.#{resource_class.name.underscore}.heading.#{action.to_s}",
    :default => "#{I18n.t(action)} #{resource_class.model_name.human.titleize}"
    )
  end

  def default_builder
    action_name.in?(%w(show)) ? Nunchaku::DisabledFormBuilder : Nunchaku::ResourceFormBuilder
  end
end
