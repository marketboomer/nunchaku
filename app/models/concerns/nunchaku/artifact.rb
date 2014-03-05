module Nunchaku::Artifact
  extend ActiveSupport::Concern

  included do
    attr_accessor :current_user

    belongs_to :creator, :class_name => 'User'
    belongs_to :updator, :class_name => 'User'

    before_save :ensure_user_trace

    scope :created_by, -> user { where(:creator_id => user.id) }
    scope :updated_by, -> user { where(:updator_id => user.id) }
  end

  module ClassMethods
    def artifact?
      true
    end
  end

  protected

  def ensure_user_trace
    self.creator ||= current_user
    self.updator = current_user if current_user.present?
  end
end
