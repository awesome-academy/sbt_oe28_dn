class Tour < ApplicationRecord
  mount_uploader :image, TourImageUploader

  has_many :users, through: :bookings
  has_many :users, through: :ratings
  has_many :ratings, dependent: :destroy
  has_many :bookings, dependent: :destroy

  delegate :approved, to: :bookings

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates :title, presence: true, length: {minimum: Settings.length.title}
  validates :description, presence: true,
    length: {maximum: Settings.length.description}
  validates :content, presence: true, length: {maximum: Settings.length.content}
  validates :price, numericality: {greater_than: Settings.zero},
    allow_nil: true

  validates :date_in, :date_out, presence: true
  validate :date_in_before_date_out
  validates :image, presence: true
  UPDATE_ATTRS = [:title, :description, :content, :price, :date_in, :date_out,
    :image].freeze

  scope :newest, ->{order created_at: :desc}

  acts_as_url :title, url_attribute: :slug, sync: true

  def to_param
    "#{id}-#{slug}"
  end

  private

  def date_in_before_date_out
    return unless date_in && date_out

    errors.add(:date_in, I18n.t("err_add.date")) if date_in > date_out
  end
end
