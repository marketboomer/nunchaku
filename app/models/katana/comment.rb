class Nunchaku::Comment < ActiveRecord::Base
  self.table_name = :nunchaku_comments

  include Nunchaku::Artifact

  attr_accessor :current_user

  belongs_to :commentable, :polymorphic => true, :counter_cache => true

  scope :created_by,  -> (user) { where(:creator_id => user.context.id) }
  scope :recent,      -> { order(arel_table[:created_at].desc) }

  validates :body, presence: true

  class << self
    def artifact?
      true
    end
  end
end