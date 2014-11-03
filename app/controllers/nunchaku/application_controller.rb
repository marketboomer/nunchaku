class Nunchaku::ApplicationController < ApplicationController

  before_filter :settle_engine_view_precedence

  protected

  def settle_engine_view_precedence
    engine_precedence.reverse.each { |e| prepend_view_path e.root.join('app','views') }
  end

  def engine_precedence
    [Nunchaku::Engine]
  end

  def controller
    self
  end
end
