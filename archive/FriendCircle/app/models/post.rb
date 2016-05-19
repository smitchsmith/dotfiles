class Post < ActiveRecord::Base
  attr_accessible :body, :user_id


  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id,
    inverse_of: :posts
  )

  has_many :links, inverse_of: :post
  has_many :post_shares
  has_many :friend_circles, through: :post_shares, source: :friend_circle, inverse_of: :posts
end
