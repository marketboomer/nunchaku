module Nunchaku
  module Composition
    extend ActiveSupport::Concern

    include ComponentIntegral
    include MaterialObject
    include MemberBunch
    include MemberPartnership
    include PlaceArea
    include PortionObject
    include TopologicalInclusion

    include Attachment
    include Attribution
    include ClassificationInclusion
    include Ownership

    included do
      # NOTE: this will probably need to be AbstractReflection for versions of
      #       ActiveRecord >= 4.2
      ::ActiveRecord::Reflection::MacroReflection.send(:include, Reflection)
    end

    module ClassMethods
      def alias_macros(config)
        config.each { |macro, aliases| alias_macro(macro, *aliases) }
      end

      def alias_macro(macro, *aliases)
        aliases.each { |a| singleton_class.send(:alias_method, a, macro) }
      end
    end
  end
end
