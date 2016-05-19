require 'twittersession'
require 'open-uri'

class Status < ActiveRecord::Base
  attr_accessible :body, :twitter_status_id, :twitter_user_id

  validates :body, :twitter_status_id, :twitter_user_id, :presence => true
  validates :twitter_status_id, :uniqueness => true

  belongs_to :user,
  :class_name => "User",
  :foreign_key => :twitter_user_id,
  :primary_key => :twitter_user_id

  def self.fetch_by_user_id(user_id)
    if internet_connection?
      path = "statuses/user_timeline"
      query_values = {:user_id => user_id}

      json = TwitterSession.get(path, query_values)
      status_objects = self.parse_json(json)

      old_ids = Status.where(:twitter_user_id => user_id).pluck(:twitter_status_id)
      status_objects.each {|object| object.save! unless old_ids.include?(object.twitter_status_id)}
      status_objects
    else
      Status.where(:twitter_user_id => user_id)
    end
  end

  def self.parse_json(json)
    statuses = JSON.parse(json)

    statuses.map do |status|
      Status.new(:body => status["text"],
                 :twitter_status_id => status["id_str"],
                 :twitter_user_id => status["user"]["id_str"])
    end
  end

  def self.post(body)
    path = "statuses/update"
    req_params = {:status => body}

    response = TwitterSession.post(path, req_params)
    response = JSON.parse(response)

    status = Status.new(:body => response["text"],
                        :twitter_status_id => response["id_str"],
                        :twitter_user_id => response["user"]["id_str"])
    status.save!
  end

  def self.internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end
end
