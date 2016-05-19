class Comment < ActiveRecord::Base
  attr_accessible :body, :owner_id, :page_id

  validates :body, :page_id, presence: true

  belongs_to :page
  belongs_to :owner, class_name: "User"
end
