module Nunchaku
  module Copying
    extend ActiveSupport::Concern

    def copy
      do_copy(:copy)
    end

    def deep_copy
      do_copy(:deep_copy)
    end

    protected

    def do_copy(method)
      copied_resource(method).save!
      copy_gflash
      copy_redirect
    end

    def copied_resource(method)
      @copied_resource = resource.send(method).tap { |r| attach_artifacts(r) }
    end

    def copy_gflash
      gflash :notice => {:value => copy_notice, :class_name => 'notice'}
    end

    def copy_redirect
      redirect_to [:edit, @copied_resource].flatten, :format => 'js'
    end

    def copy_notice
      nil
    end

    def activity_whitelist
      super + %w(copy)
    end
  end
end
