class TagTopic < ActiveRecord::Base
  validates :tag, :inclusion => { :in => %w(news sports music),
    :message => "%{value} is not a valid tag"}, :allow_nil => true

  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :tag_topic_id,
    :primary_key => :id
  )

  has_many :shortened_urls, :through => :taggings, :source => :shortened_url

  def self.create_if_not_existing!(tag)
    tag_object = TagTopic.find_by_tag(tag)

    if tag_object.nil?
      tag_object = TagTopic.new
      tag_object.tag = tag
      tag_object.save!
    end

    tag_object
  end

  def self.most_popular_link(tag)
    tag_object = TagTopic.find_by_tag(tag)
    ShortenedUrl
      .joins("JOIN taggings ON taggings.shortened_url_id = shortened_urls.id")
      .joins("JOIN visits ON taggings.shortened_url_id = visits.shortened_url_id")
      .joins("JOIN tag_topics ON tag_topics.id = taggings.tag_topic_id")
      .where("tag_topics.id = #{tag_object.id}")
      .group("shortened_urls.id")
      .order("COUNT(visits.id) DESC")
      .limit("1")
      .first
  end

end