class User < ActiveRecord::Base
  attr_accessible :user_name, :password
  attr_reader :password

  before_validation :ensure_session_token
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true

  has_many :cats


  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end