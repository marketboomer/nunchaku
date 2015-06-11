module Nunchaku
  class ResourceInlineEditor

    attr_accessor :resource_class,
                  :object,
                  :resource_params,
                  :link_url,
                  :template

    def initialize(object, resource_params, link_url, template)
      self.object = object
      self.resource_class = object.class
      self.resource_params = resource_params
      self.link_url = link_url
      self.template = template
    end

    def state(options)
      with_edit(:text, object, :state, options.reverse_merge({:disabled => true}))
    end

    def supported_languages_source
      APP_CONFIG['supported_languages'].keys.map { |l| {:value => l, :text => APP_CONFIG['supported_languages'][l]} }
    end

    def time_zone_source
      ActiveSupport::TimeZone.all.map { |z| {:value => z.name, :text => z.to_s} }
    end

    def method_missing(method, *args, &block)
      with_edit(editor_type(method), object, method, args.first, &block)
    end

    def with_edit(type, resource, attr_name, options={}, &block)
      input = editable_input(type, resource, attr_name, options.reverse_merge!(:resource => resource_params, :url => link_url))
      link_text = block_given? ? yield : editable_link_text(resource, attr_name, type)
      template.link_to(link_text.to_s, '#', :data => input.config, :id => "edit_#{attr_name}") << input.javascript
    end

    protected

    def editable_input(type, resource, attr_name, options)
      editable_input_class(type).new(resource, attr_name, template, options)
    end

    def editable_input_class(type)
      "Nunchaku::InlineInputs::#{type.to_s.camelize}".constantize
    rescue NameError => e
      InlineInputs::Text
    end

    def editable_link_text(resource, attr_name, type)
      unless type == :boolean
        resource.send(attr_name)
      else
        resource.send(attr_name) ? I18n.t(:yes) : I18n.t(:no)
      end
    end

    def editor_type(method)
      case resource_class.columns_hash[method.to_s].try(:type).to_s
        when /date/ then
          :combodate
        when /boolean/ then
          :boolean
        else
          :text
      end
    end

  end
end