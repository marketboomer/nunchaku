module Nunchaku
  module Workflow

    def record_event(event_name)
      if resource.send(event_name)
        yield if block_given?
        gflash :notice => {:value => t("flash_unrest.#{engine_name}.#{controller_name}.#{resource.state}.notice", interpolation_options), :class_name => 'notice'}
        resource.save
      else
        gflash :error => {:value => [resource.to_s, resource.errors.full_messages()].flatten.join(' '),:class_name=>'error'}
      end
      redirect_after_event
    end

    def redirect_after_event
      respond_with with_nesting(controller_name)
    end
  end
end
