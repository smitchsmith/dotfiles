class Favorite < ActiveRecord::Base
  attr_accessible :user_id, :page_id

  validates :user_id, :page_id, presence: true
  validates :user_id, uniqueness: { scope: :page_id }

  belongs_to :user
  belongs_to :page

end
