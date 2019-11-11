class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tours, through: :bookings, dependent: :destroy
  has_many :tours, through: :ratings, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :bookings, dependent: :destroy

  before_save{email.downcase!}
  validates :user_name, presence: true, length: {maximum: Settings.username}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  enum role: [:admin, :user]
  has_secure_password
  validates :password, presence: true, length: {minimum:
    Settings.password}, allow_nil: true

  class << self
    def digest string
      if cost = ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password?(token)
  end
end
