module Nunchaku
  module Transitions
    extend ActiveSupport::Concern

    included do
      resource_class.events.each do |e|
        define_method(e) do
          record_event(e)
        end
      end
    end

    protected

    def record_event(event_name)
      resource.send(event_name)

      yield if block_given?

      resource.save!

      gflash :notice => {:value => t("flash_unrest.#{resource.general_class.name.underscore.gsub('/', '.').pluralize}.#{resource.state}.notice", interpolation_options), :class_name => 'notice'}

    rescue
      resource.update_column(:state, resource.state)

      gflash :error => { :value => resource.errors.full_messages.to_sentence, :class_name=>'error' }
    ensure
      respond_with with_nesting(controller_name)
    end
  end
end
