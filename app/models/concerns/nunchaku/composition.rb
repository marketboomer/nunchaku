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
  end
end
