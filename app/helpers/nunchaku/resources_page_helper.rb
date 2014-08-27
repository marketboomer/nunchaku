module Nunchaku::ResourcesPageHelper
  def content_header(resource = nil)
    render :partial => 'content_header', :locals => { :resource => resource }
  end

  def page_title
    (resource? ? resource.decorate.to_s : nested_collection_name).html_safe
  end
end
