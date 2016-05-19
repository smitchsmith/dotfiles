class Page < ActiveRecord::Base
  attr_accessible :title, :password, :is_public, :syntax_id
  attr_accessor :password

  validates :title, :url_fragment, presence: true
  validates :is_public, inclusion: { in: [true, false] }
  validates :url_fragment, uniqueness: true, length: { minimum: 2 }
  validates :password, length: { minimum: 6 }, allow_nil: true

  belongs_to :owner, class_name: "User"
  has_many :comments
  has_many :versions
  has_many :favorites
  has_many :favorited_by_users, through: :favorites , source: :user

  has_many :shares
  has_many :shared_users, through: :shares, source: :sharee

  has_many :binaries

  has_many :saved_passwords

  belongs_to :syntax

  def password=(password)
    unless password.empty?
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def is_password?(password)
   BCrypt::Password.new(password_digest).is_password?(password)
  end

  def is_public?
    self.is_public
  end

  def highlighting
    self.syntax.highlighting
  end

end
