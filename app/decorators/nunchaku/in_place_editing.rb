module Nunchaku::InPlaceEditing
  extend ActiveSupport::Concern

  protected

  def in_place_edit(element_name)
    m = "#{element_name}_with_edit"

    if respond_to?("#{element_name}_with_edit")
      send(m)
    else
      with_edit(element_name)
    end
  end

  def with_edit(element_name, options={}, &block)
    h.link_to (block_given? ? yield : send(element_name)), '', :data => with_element_options(element_name).merge(options)
  end

  def with_element_options(element_name)
    {
      :behaviour => 'editable',
      :mode => 'inline',
      :onblur => 'submit',
      :toggle => 'mouseenter',
      :showbuttons => false,
      :name => element_name,
      :resource => h.resource_instance_name,
      :type => element_type(element_name).to_s,
      :pk => resource.id,
      :url => "#{h.resource_path(resource)}.json"
    }
  end

  def element_type(element_name)
    self.class.edit_in_place_elements[element_name.to_sym] || 'text'
  end
end