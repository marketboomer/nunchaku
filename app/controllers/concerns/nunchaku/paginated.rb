module Nunchaku::Paginated
  extend ActiveSupport::Concern

  included do
    helper_method :paged_collection, :current_page, :read_ahead_count, :sweet_ux_count, :per_page
  end

  protected

  def collection
    memoize_collection { paged_formats.include?(request.format.symbol) ? super.page(current_page).per(per_page).with_read_ahead(read_ahead_count) : super }
  end

  def paged_formats
    %i(html)
  end

  def paged_collection
    collection
  end

  def current_page
    params[page_param_name] || 1
  end

  def per_page
    params[rows_param_name] || resource_class.default_per_page
  end

  def read_ahead_count
    0
  end

  def sweet_ux_count
    cc = collection.size
    cc <= show_ahead_count ? cc : per_page
  end

  def show_ahead_count
    per_page + read_ahead_count - 1
  end

  def page_param_name
    :page
  end

  def rows_param_name
    :rows
  end
end
