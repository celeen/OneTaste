class Comment < ActiveRecord::Base
  has_many :votes, as: :voteable
  has_many :replies, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :review
  belongs_to :parent, class_name: "Comment"
  belongs_to :commenter, class_name: "User"

  validates_presence_of :content
  validates_presence_of :review_id
end
