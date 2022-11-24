class Bbq < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  validates_presence_of :title, :price, :description, :location, :manufacturer
  validates :description, length: { minimum: 6, maximum: 200 }
  validates :title, length: { minimum: 6, maximum: 50 }

  before_save :photos_check
  # validate minimum 2 photos

  include PgSearch::Model
  pg_search_scope :search_by_title_and_model,
                  against: [:title, :model],
                  using: {
                    tsearch: { prefix: true }
                  }

  private

  def photos_check
    errors.add(:photos, 'You must upload at least 3 photos of dis grill') if :photos.length < 3
  end
end
