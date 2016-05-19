class Link < ActiveRecord::Base
  attr_accessible :title, :url, :text, :user_id

  validates :title, :url, :user_id, presence: true
  validates :url, uniqueness: true

  belongs_to :submitter,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id

  has_many :link_subs,
  class_name: "LinkSub",
  foreign_key: :link_id,
  primary_key: :id

  has_many :subs,
  through: :link_subs,
  source: :sub

  has_many :comments,
  class_name: "Comment",
  foreign_key: :link_id,
  primary_key: :id

  def comments_by_parent_id
    comments = self.comments
    hash = Hash.new{ |h,k| h[k] = [] }
    comments.each do |comment1|
      hash[nil] << comment1 if comment1.parent_comment_id.nil?
      comments.each do |comment2|
        hash[comment1.id] << comment2 if (comment1.id == comment2.parent_comment_id)
      end
    end

    hash
  end

end

