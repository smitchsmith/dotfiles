class Comment < ActiveRecord::Base
  attr_accessible :text, :link_id, :parent_comment_id, :user_id

  validates :text, :link_id, :user_id, presence: true

  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id

  belongs_to :link,
  class_name: "Link",
  foreign_key: :link_id,
  primary_key: :id

end
