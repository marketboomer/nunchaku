module Nunchaku::ResourcesButtonHelper
  def new_resource_button(*args)
    options = args.extract_options!
    path, klass = args
    options.reverse_merge! :class => 'btn navbar-btn btn-success', :remote => true

    link_to((path || new_resource_path), options) do
      new_icon << ' ' << button_text(:new)
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

  def sort_button(disabled=false)
    link_to [:sortable, nests, resource_class].flatten, :class => 'btn navbar-btn btn-warning', :disabled => disabled do
      sort_icon << ' ' << button_text(:sort)
    end
  end

  def update_button(return_link, disabled=false)
    link_to return_link, :class => 'btn navbar-btn btn-success', :disabled => disabled do
      update_icon << ' ' << button_text(:update)
    end
  end

  def back_button(return_link)
    link_to return_link, :class => 'btn navbar-btn btn-default' do
      back_icon << ' ' << button_text(:back)
    end
  end

  def done_button(return_link, disabled=false)
    link_to return_link, :class => 'btn navbar-btn btn-success', :disabled => disabled do
<<<<<<< HEAD
      check_icon << ' ' << t(:done)
=======
      check_icon << ' ' << button_text(:done)
>>>>>>> 9d61b5c112b02c40ab570926799820b6727e0636
    end
  end

  def report_export_button(format = :csv)
    content_tag(:div, :class => 'btn navbar-btn btn-info') do
      link_to export_icon, params.merge(:format => format)
    end
  end

  def pdf_button
    content_tag(:div, :class => 'btn navbar-btn btn-info') do
      pdf_link
    end
  end

  def pdf_link
    link_to pdf_icon, params.merge(:format => :pdf)
  end

  def print_button
    content_tag(:div, :class => 'btn navbar-btn btn-info') do
      link_to print_icon,'javascript:print();'
    end
  end

  protected

  def button_text(symbol)
    content_tag(:span, t(symbol), :class => 'hidden-xs hidden-sm')
  end
end
