class User < ActiveRecord::Base
  attr_accessible :username, :password, :session_token

  before_validation(:ensure_session_token, on: :create)
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true

  has_many :subs,
  class_name: "Sub",
  foreign_key: :user_id,
  primary_key: :id

  has_many :links,
  class_name: "Link",
  foreign_key: :user_id,
  primary_key: :id

  has_many :comments,
  class_name: "Comment",
  foreign_key: :user_id,
  primary_key: :id


  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)

    if @user && @user.is_password?(password)
      @user
    else
      nil
    end
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

end
