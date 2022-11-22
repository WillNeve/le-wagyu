class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bbq
  validates_presence_of :rating, :comment
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :comment, length: { minimum: 6 }
end
