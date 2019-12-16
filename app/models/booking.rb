class Booking < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :tour

  enum status: [:approved, :canceled, :in_progress]

  validates :name, presence: true, length: {minimum: Settings.length.name}
  validates :phone, presence: true, length: {minimum: Settings.length.phone}

  UPDATE_ATTRS = [:name, :phone].freeze

  delegate :title, :price, to: :tour

  scope :check_booking,
    ->(tour_id, id){where "tour_id = ? AND id = ?", tour_id, id}
  scope :newest, ->{order created_at: :desc}
end
