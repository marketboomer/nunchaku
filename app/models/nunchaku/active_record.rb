module Nunchaku
  class ActiveRecord < ActiveRecord::Base
    self.abstract_class = true

    include Resourceable
    include Reflections
    include Composition

    def self.engine
      parents.detect do |parent|
        begin
          return "#{parent}::Engine".constantize
        rescue NameError
          # NOTE: +#safe_constantize+ isn't used here because it still throws an
          #       exception when looking at +Object+
        end
      end
    end

    def to_sym
      to_s.titleize.delete(' ').underscore.to_sym
    end
  end
end
