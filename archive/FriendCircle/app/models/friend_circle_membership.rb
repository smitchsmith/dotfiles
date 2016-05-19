class FriendCircleMembership < ActiveRecord::Base
  attr_accessible :friend_circle_id, :friend_id

  validates :friend_circle, presence: true
  validates :friend, presence: true

  belongs_to :friend_circle

  belongs_to(
    :friend,
    class_name: "User",
    foreign_key: :friend_id
  )

  # has_one(
  #   :circle_owner,
  #   class_name: "User",
  #   foreign_key: :user_id,
  #   through: :friend_circle,
  #   source: :owner
  # )

end
