class Review < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy

  validates :description, presence: true,
    length: {maximum: Settings.description}
  validates :title, :content, presence: true
  validates :image, presence: true
  validates :image, presence: true, allow_nil: true, on: :update_review

  scope :newest, ->{order created_at: :desc}
end
