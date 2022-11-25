class Like < ApplicationRecord
  belongs_to :user
  belongs_to :bbq
  validates_uniqueness_of :user_id, :bbq_id
end
