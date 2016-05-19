class Binary < ActiveRecord::Base
  attr_accessible :page_id, :file, :title

  has_attached_file :file

  validates :title, presence: true

  do_not_validate_attachment_file_type :file

  validates_attachment :file, presence: true,
    size: { less_than: 5.megabytes }

  belongs_to :page
end
