class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }
  scope :by_commentable, -> commentable_id, commentable_type { 
    where(commentable_id: commentable_id, commentable_type: commentable_type)
  }
  
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
end
