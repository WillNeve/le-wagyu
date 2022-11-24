class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bbq

  validates :start_date, :end_date, presence: true
  # validates :end_date_after_start_date, presence: true

  # def end_date_after_start_date
  #   return if end_date.blank? || start_date.blank?
  #   if end_date < start_date
  #     errors.add(:end_date 'Sorry bruv, get your dates right')
  #   end
  # end

  private

  def start_time
    self.my_related_model.start
  end
end
