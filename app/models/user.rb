class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :validatable, :lockable,
    :timeoutable, :trackable, :omniauthable,
    omniauth_providers: [:facebook]
  USER_PARAMS = %i(email full_name).freeze
  USER_PARAMS_ADMIN = %i(email full_name password password_confirmation).freeze

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tours, through: :bookings, dependent: :destroy
  has_many :tours, through: :ratings, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :bookings, dependent: :destroy

  before_save{email.downcase!}
  validates :full_name, presence: true, length: {maximum: Settings.username}
  enum role: [:admin, :user]

  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :finders]

  scope :newest, ->{order created_at: :desc}
  class << self
    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
                  session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.full_name = auth.info.name
        user.image = auth.info.image
      end
    end
  end
end
