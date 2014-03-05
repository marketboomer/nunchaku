module Nunchaku::ResourcesPageHelper
  def content_header(resource = nil)
    content_tag(:div, :class => 'page-header page-header-tabbed') do
      render :partial => 'content_header', :locals => { :resource => resource }
    end
  end

  def page_title
    (resource? ? resource.decorate.to_s : nested_collection_name).html_safe
  end
end