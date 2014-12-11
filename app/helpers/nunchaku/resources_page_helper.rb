module Nunchaku::ResourcesPageHelper
  def content_header(resource = nil)
    render :partial => 'content_header', :locals => { :resource => resource }
  end

  def page_title
    (resource? ? resource.decorate.to_s : nested_collection_name).html_safe
  end

  def page_title_type
    (resource? ? human(resource.class) : nested_collection_type).html_safe
  end

  def maybe_more_records
    if collection.count > sweet_ux_count
      link_to "#{t(:more_records)}&#8230;".html_safe, params.merge(:page => current_page.to_i + 1), :rel => 'next'
    else
      t(:no_more_records)
    end
  end
end
