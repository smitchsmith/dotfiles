class Link < ActiveRecord::Base
  attr_accessible :address, :post_id

  belongs_to :post, inverse_of: :links
end
