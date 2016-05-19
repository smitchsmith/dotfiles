class User < ActiveRecord::Base
  attr_accessible :email, :password, :session_token
  attr_reader :password

  has_many :friend_circles, inverse_of: :owner

  has_many(
    :friend_circle_memberships,
    class_name: "FriendCircleMembership",
    foreign_key: :friend_id,
    primary_key: :id
  )

  has_many :friended_circles, through: :friend_circle_memberships,
           source: :friend_circle, inverse_of: :friends

  has_many(:posts,
   class_name: "Post",
   foreign_key: :user_id,
   inverse_of: :author)

  has_many :post_feeds, through: :friended_circles, source: :posts

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true
  before_validation :ensure_session_token

  def self.find_by_credentials(email, password)
    user = find_by_email(email)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
   end

   def create_reset_token!
     self.reset_token = SecureRandom::urlsafe_base64(16)
     self.save!
   end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
  end

  def password=(password)
    if password
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def send_forgot_pwd_email
    msg = UserMailer.forgot_password(self)
    msg.deliver!
  end

end
