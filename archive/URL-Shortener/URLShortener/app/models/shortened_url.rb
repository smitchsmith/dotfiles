class ShortenedUrl < ActiveRecord::Base
  attr_accessible :long_url, :short_url, :submitter_id

  validates :long_url, :presence => true, :length => { :maximum => 100 }
  validates :short_url, :presence => true, :uniqueness => true
  validates :submitter_id, :presence => true
  validate :user_not_exceeded_submission_limit

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
    )

  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
    )

  has_many :visitors, :through => :visits, :uniq => true, :source => :user
  has_many :tags, :through => :taggings, :uniq => true, :source => :tag_topic

  def self.random_code
    url = SecureRandom::urlsafe_base64(16)

    until ShortenedUrl.find_by_short_url(url).nil?
      url = SecureRandom::urlsafe_base64(16)
    end

    url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    s = ShortenedUrl.new
    s.long_url = long_url
    s.short_url = ShortenedUrl.random_code
    s.submitter_id = user.id

    s.save!

    s
  end

  def num_clicks
    Visit.where(:shortened_url_id => self.id).count
  end

  def num_uniques
    Visit.where(:shortened_url_id => self.id).distinct.count
  end

  def num_recent_uniques(mins_ago = 10)
    time_diff = ((Time.now - (60 * mins_ago))..Time.now)
    Visit.where(:shortened_url_id => self.id, :created_at => time_diff).distinct.count
  end

  private
  def user_requests
    time_diff = ((Time.now - 60)..Time.now)
    ShortenedUrl.where(:submitter_id => self.submitter_id, :created_at => time_diff).count
  end

  def user_not_exceeded_submission_limit(n = 5)
    if user_requests >= n
      errors[:submissions] << "can't be more than #{n} in the last minute"
    end
  end

end