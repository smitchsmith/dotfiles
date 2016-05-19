class User < ActiveRecord::Base
  attr_accessible :username, :email, :password
  attr_accessor :password

  validates :username, :email, :password_digest, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :email, format: { with: /@/ }
  validates :username, format: { without: /@/ }

  has_many :pages, foreign_key: "owner_id"
  has_many :comments, foreign_key: "owner_id"
  has_many :favorites
  has_many :favorite_pages, through: :favorites , source: :page

  has_many :shares, foreign_key: "sharee_id"
  has_many :shared_to_pages, through: :shares, source: :page

  has_many :session_tokens

  has_many :saved_passwords


  def self.find_by_credentials(un_or_email, password)
    user = self.find_by_username(un_or_email) || self.find_by_email(un_or_email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
   BCrypt::Password.new(password_digest).is_password?(password)
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def reset_password_reset!
    self.password_reset = generate_token
    self.save!
  end

end