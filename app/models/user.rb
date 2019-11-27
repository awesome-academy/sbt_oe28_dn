class User < ApplicationRecord
  USER_PARAMS = %i(email full_name password password_confirmation)
                .freeze
  USER_PARAMS_UPDATE = [:email, :full_name].freeze

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :tours
  has_many :likes, dependent: :destroy

  enum role: [:admin, :user]

  scope :newest, ->{order created_at: :desc}

  validates :full_name, presence: true, length: {maximum: 50}

  def is_admin?
    admin?
  end

  def self.from_omniauth auth
    user = where(email: auth.info["email"]).first
    return user if user.present?
    password = Devise.friendly_token[0, 20]
    User.create(
      refresh_token: auth.credentials.refresh_token,
      token: auth.credentials.token,
      expires_at: Time.at(auth.credentials.expires_at),
      uid: auth.uid,
      email: auth.info["email"],
      name: auth.info["name"],
      full_name: auth.info["name"],
      google_app_id: ENV["google_app_id"],
      channel_id: ENV["channel_id"],
      password: password,
      password_confirmation: password
    )
  end
end
