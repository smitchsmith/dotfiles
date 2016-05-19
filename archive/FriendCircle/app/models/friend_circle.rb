class FriendCircle < ActiveRecord::Base
  attr_accessible :title, :user_id

  validates :title, presence: true
  validates :owner, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :friend_circles
  )

  has_many :friend_circle_memberships
  has_many :friends, through: :friend_circle_memberships, source: :friend , inverse_of: :friended_circles
  has_many :post_shares
  has_many :posts, through: :post_shares, source: :post, inverse_of: :friend_circles
end
