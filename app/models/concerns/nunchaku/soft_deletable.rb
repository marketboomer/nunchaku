module Nunchaku
  module SoftDeletable
    extend ActiveSupport::Concern

    included do
      default_scope { where(:is_deleted => false) }

      alias_method :destroy!, :destroy
      alias_method :delete!, :delete

      before_destroy :rename
    end

    def destroy
      run_callbacks(:destroy) do
        soft_delete
      end
    end

    def delete
      return if new_record?
      soft_delete
    end

    def name_unique?
      false
    end

    def name_field
      :name
    end

    protected

    def rename
      assign_attributes(name_field => "#{send(name_field)} - DELETED") if name_unique?
    end

    def soft_delete
      self.is_deleted = true
      save!
    end
  end
end
