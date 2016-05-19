class SessionToken < ActiveRecord::Base
  attr_accessible :token, :user_id

  before_validation :ensure_token

  validates :token, :user_id, presence: true

  belongs_to :user

  def ensure_token
    self.token ||= SecureRandom.urlsafe_base64
  end

end
