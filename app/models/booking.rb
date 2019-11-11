class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  enum status: [:approved, :canceled, :in_progress]

  validates :name, presence: true, length: {minimum: Settings.length.name}
  validates :phone, length: {minimum: Settings.length.phone}

  scope :ticket, ->(_status){where status: "approved"}
  scope :check_booking,
    ->(tour_id, id){where "tour_id = ? AND id = ?", tour_id, id}
end
