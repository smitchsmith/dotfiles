class User < ActiveRecord::Base
  attr_accessible :session_token, :password_digest, :email, :password, :activated, :activation_token

  before_validation :ensure_session_token

  has_many :notes

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) && user.activated ? user : nil
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def ensure_activated
    self.activated ||= false
  end

  def ensure_activation_token
    self.activation_token ||= generate_activation_token
  end

  def generate_session_token
    SecureRandom.base64
  end

  def generate_activation_token
    SecureRandom.base64
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
  end

  def generate_password(password)
    BCrypt::Password.create(password)
  end

  def password=(password)
    @password = password
    self.password_digest = generate_password(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def send_activation_email
    email = UserMailer.welcome_email(self)
    email.deliver!
  end

end