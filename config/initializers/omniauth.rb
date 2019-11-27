Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["client_id"], ENV["secret_id"], skip_jwt: true
end
