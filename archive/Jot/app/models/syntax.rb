class Syntax < ActiveRecord::Base
  attr_accessible :highlighting, :title

  validates :highlighting, :title, presence: true
  has_many :pages
end
