class Nunchaku::ApplicationController < ApplicationController

  before_filter :settle_engine_view_precedence
  before_filter :set_default_response_format

  protected

  def settle_engine_view_precedence
    engine_precedence.reverse.each { |e| prepend_view_path e.root.join('app','views') }
  end

  def engine_precedence
    [Nunchaku::Engine]
  end

  def set_default_response_format
    request.format = :html if request.format == "*/*"
  end
end
