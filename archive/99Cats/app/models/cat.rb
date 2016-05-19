class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex, :user_id

  validates :age, :birth_date, :color, :name, :sex, :presence => true
  validates :age, :numericality => { :only_integer => true }
  validates :color, :inclusion => { :in => %w[white black grey] }
  validates :sex, :inclusion => { :in => %w[M F] }

  has_many :cat_rental_requests, dependent: :destroy

  belongs_to :owner, class_name: "User", foreign_key: :user_id
end