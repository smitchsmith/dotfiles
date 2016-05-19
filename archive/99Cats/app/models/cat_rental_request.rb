class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: %w(PENDING APPROVED DENIED)}
  validate  :overlapping_approved_requests

  belongs_to :cat

  before_validation do
    self.status ||= "PENDING"
  end

  def overlapping_requests
    sql = <<-SQL
            #{self.cat_id} = cat_rental_requests.cat_id
    AND     ("#{self.start_date}" BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date
    OR       "#{self.end_date}" BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date
    OR        cat_rental_requests.start_date BETWEEN "#{self.start_date}" AND "#{self.end_date}"
    OR        cat_rental_requests.end_date BETWEEN "#{self.start_date}" AND "#{self.end_date}")
    SQL

    CatRentalRequest.where(sql)
  end

  def overlapping_approved_requests
    if self.id
      if overlapping_requests.where(:status => "APPROVED").count > 1
        errors[:request] << "can't overlap with other approved requests"
      end
    else
      if overlapping_requests.where(:status => "APPROVED").count > 0
        errors[:request] << "can't overlap with other approved requests"
      end
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(:status => "PENDING")
  end

  def approve!
    CatRentalRequest.transaction do
      overlapping_pending_requests.each do |request|
        request.deny!
      end
      self.update_attributes(:status => "APPROVED")
    end
  end

  def deny!
    self.update_attributes(:status => "DENIED")
  end

end