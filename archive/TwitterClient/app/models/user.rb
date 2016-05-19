require 'twittersession'

class User < ActiveRecord::Base
  attr_accessible :screen_name, :twitter_user_id
  validates :screen_name, :twitter_user_id, :presence => true, :uniqueness => true

  has_many :statuses,
  :class_name => "Status",
  :foreign_key => :twitter_user_id,
  :primary_key => :twitter_user_id

  has_many :inbound_follows,
  :class_name => "Follow",
  :foreign_key => :twitter_follower_id,
  :primary_key => :twitter_user_id

  has_many :outbound_follows,
  :class_name => "Follow",
  :foreign_key => :twitter_followee_id,
  :primary_key => :twitter_user_id

  has_many :followed_users, :through => :outbound_follows, :source => :follower
  has_many :followers, :through => :inbound_follows, :source => :followee

  def self.fetch_by_screen_name!(screen_name)
    path = "users/show"
    query_values = {:screen_name => screen_name}

    json = TwitterSession.get(path, query_values)
    self.parse_twitter_user(json).first
  end

  def self.get_by_screen_name(screen_name)
    User.find_by_screen_name(screen_name) || fetch_by_screen_name!(screen_name)
  end

  def self.parse_twitter_user(json)

    parsed_jsons = JSON.parse(json)
    parsed_jsons = parsed_jsons.is_a?(Array) ? parsed_jsons : [parsed_jsons]

    parsed_jsons.map do |parsed_json|
      User.create!(:screen_name => parsed_json["screen_name"].downcase,
        :twitter_user_id => parsed_json["id_str"])
    end
  end

  def self.create_twitter_user(result)
    User.create!(:screen_name => result["screen_name"].downcase,
      :twitter_user_id => result["id_str"])
  end

  def self.fetch_by_ids(ids)
    not_found = []
    found = []
    ids.each do |id|
      user = User.find_by_twitter_user_id(id)
      user.nil? ? not_found << id : found << user
    end

    query_values = {:user_id => not_found.join(",")}
    results = TwitterSession.get("users/lookup", query_values)
    results = self.parse_twitter_user(results)
    results + found
  end

  def fetch_statuses!
    Status.fetch_by_user_id(self.twitter_user_id)
  end

end
