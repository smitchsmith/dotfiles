class Tagging < ActiveRecord::Base
  belongs_to(
  :tag_topic,
  :class_name => "TagTopic",
  :foreign_key => :tag_topic_id,
  :primary_key => :id
  )

  belongs_to(
  :shortened_url,
  :class_name => "ShortenedUrl",
  :foreign_key => :shortened_url_id,
  :primary_key => :id
  )

  belongs_to(
  :user,
  :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id
  )

  def self.create_for_user_and_long_url!(user, short_url, tag_topic)
    t = Tagging.new
    t.user_id = user.id
    t.shortened_url_id = short_url.id
    t.tag_topic_id = tag_topic.id

    t.save!

    t
  end

end