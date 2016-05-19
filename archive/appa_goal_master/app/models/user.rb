class User < ActiveRecord::Base
  attr_accessible :password_digest, :token, :username, :password

  validates :password_digest, :username, presence: true

  has_many :goals


  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_token!
    self.token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.token
  end

  def public_goals
    self.goals.where(visibility: true)
  end




end
