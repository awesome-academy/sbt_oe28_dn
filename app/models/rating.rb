class Rating < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  UPDATE_ATTRS = [:rating_value].freeze

  scope :check_rating,
    ->(user_id, tour_id){where "user_id = ? AND tour_id = ?", user_id, tour_id}
end
