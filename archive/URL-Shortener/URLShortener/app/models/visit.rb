class Visit < ActiveRecord::Base
  validates :submitter_id, :presence => true
  validates :shortened_url_id, :presence => true

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  belongs_to(
    :shortened_url,
    :class_name => "ShortenedUrl",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  def self.record_visit!(user, shortened_url)
    v = Visit.new
    v.submitter_id = user.id
    v.shortened_url_id = shortened_url.id

    v.save!
  end
end