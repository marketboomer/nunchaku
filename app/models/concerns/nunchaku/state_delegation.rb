module Nunchaku
  module StateDelegation
    extend ActiveSupport::Concern
    include Nunchaku::Reflections

    module ClassMethods
      def delegate_to_machine(association)
        delegate *(class_for(association).state_questions << :state), :to => association, :allow_nil => true
      end
    end
  end
end
