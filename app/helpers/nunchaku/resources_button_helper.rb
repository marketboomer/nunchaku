module Nunchaku::ResourcesButtonHelper
  def new_resource_button(*args)
    options = args.extract_options!
    path, klass = args
    options.reverse_merge! :class => 'btn navbar-btn btn-success', :remote => true

    link_to((path || new_resource_path), options) do
      new_icon << ' ' << t(:new)
    end
  end

  def new_resource_button_text(klass = resource_class)
    object_name = klass.name.underscore
 
    translate("helpers.button.#{object_name}.new",
              :model => human(klass),
              :default => [
                :'helpers.button.new',
                human(klass)
              ]).titleize
  end

  def update_button(return_link, disabled)
    link_to return_link, :class => 'btn navbar-btn btn-success', :disabled => disabled do
      update_icon << ' ' << t(:update)
    end
  end

  def back_button(return_link)
    link_to return_link, :class => 'btn navbar-btn btn-default' do
      back_icon << ' ' << t(:back)
    end
  end

  def done_button(return_link, disabled)
    link_to return_link, :class => 'btn navbar-btn btn-success', :disabled => disabled do
      t(:done)
    end
  end
end