module Nunchaku
  module FuzzyAssociationSearchable
    extend ActiveSupport::Concern
    include Nunchaku::FuzzySearch

    module ClassMethods

      def fuzzy_search(terms, opts = {})
        fuzzy_search_association ? preload(fuzzy_search_association).joins(fuzzy_search_association).merge(association_class.fuzzy_search(terms, opts)) : super
      end

      def fuzzy_search_association
        nil
      end

      private

      def association_class
        reflect_on_association(fuzzy_search_association).class_name.constantize
      end
    end
  end
end