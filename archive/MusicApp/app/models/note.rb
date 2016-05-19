class Note < ActiveRecord::Base
  attr_accessible :body, :track_id, :user_id
  belongs_to :user
  belongs_to :track
end
