class SavedPassword < ActiveRecord::Base
  attr_accessible :page_id, :user_id, :digest

  validates :page_id, :user_id, :digest, presence: true

  validates :user_id, uniqueness: { scope: :page_id }

  belongs_to :page
  belongs_to :user

end
