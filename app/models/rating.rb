class Rating < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  scope :check_rating, ->(u, t){where "user_id = ? AND tour_id = ?", u, t}
end
