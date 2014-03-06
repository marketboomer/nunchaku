module Nunchaku::Artifacts
  extend ActiveSupport::Concern

  protected

  def build_resource(*args)
    memoize_resource do
      super.tap do |r|
        r.current_user = current_user
      end
    end
  end

  def update_resource(attributes)
    resource.current_user = current_user
    
    super
  end
end
