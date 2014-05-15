module Nunchaku::ApplicationHelper
  include Nunchaku::LocaleHelper
  include Nunchaku::BootstrapHelper
  include Nunchaku::IconsHelper

  def engine_name
    controller.class.name.deconstantize.downcase
  end
end
