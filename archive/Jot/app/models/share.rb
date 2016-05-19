class Share < ActiveRecord::Base
  attr_accessible :page_id, :sharer_id, :sharee_id

  validates :page_id, :sharer_id, :sharee_id, presence: true

  belongs_to :page
  belongs_to :sharer, class_name: "User"
  belongs_to :sharee, class_name: "User"
end
