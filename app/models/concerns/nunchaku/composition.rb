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

    # module AssociationBuilderExtension
    #   def self.valid_options
    #     %i(association_kind)
    #   end

    #   def self.build(model, reflection)
    #     # do nothing
    #   end
    # end

    # included do
    #   ::ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    # end

    # include ComponentIntegralComposition
    # include MaterialObjectComposition
    # include MemberBunchComposition
    # include MemberPartnershipComposition
    # include PlaceAreaComposition
    # include PortionObjectComposition

    # include Attachment
    # include Attribution
    # include ClassificationInclusion
    # include Ownership
  end
end
