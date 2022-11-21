class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bbq
  validates_presence_of :start_date, :end_date
  # validates :end_date_after_start_date

  private

  def end_date_after_start_date
    # return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, 'Sorry bruv, get your dates right')
    end
  end
end
