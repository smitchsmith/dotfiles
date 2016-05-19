class Version < ActiveRecord::Base
  attr_accessible :page_id, :body, :number

  validates :page_id, :body, :number, presence: true

  belongs_to :page

end
