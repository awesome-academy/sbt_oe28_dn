class Rating < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  scope :check_rating,
    ->(uid, tid){where "user_id = ? AND tour_id = ?", uid, tid}
end
