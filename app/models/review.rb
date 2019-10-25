class Review < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :description, presence: true,
    length: {maximum: Settings.description}
  validates :title, :content, presence: true
  validates :category,
    inclusion: {in: [1, 2, 3]}
  scope :newest, ->{order created_at: :desc}
  validates :image, presence: true
  validates :image, presence: true, allow_nil: true, on: :update_review
  scope :newest, ->{order created_at: :desc}
  scope :load_review, ->(id){where category: id}
end
