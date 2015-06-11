module Nunchaku
  module InlineInputs
    class Text < Base
      def config
        super.merge({:type => 'text'})
      end
    end
  end
end