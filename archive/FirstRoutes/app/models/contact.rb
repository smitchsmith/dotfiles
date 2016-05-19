class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :user_id
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :owner, class_name: "User", foreign_key: :user_id, primary_key: :id
  has_many :contact_shares
  has_many :shared_users, through: :contact_shares, source: :user

  def self.contacts_for_user_id(user_id)
    Contact
    .joins("LEFT OUTER JOIN contact_shares ON contact_shares.contact_id = contacts.id")
    .where(["contact_shares.user_id = ? OR contacts.user_id = ?", user_id, user_id])
  end

end
