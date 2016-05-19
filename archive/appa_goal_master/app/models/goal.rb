class Goal < ActiveRecord::Base
  attr_accessible :title, :user_id, :description, :visibility, :completed
  validates :title, :user_id, presence: true

  belongs_to :user

  before_validation :ensure_defaults

  def ensure_defaults
    self.completed ||= false
    self.visibility ||= false
    true
  end
end
