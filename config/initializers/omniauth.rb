Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["google_client_id"], ENV["google_client_secret"], { :scope => 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar, https://www.googleapis.com/auth/gmail.readonly, https://www.googleapis.com/auth/gmail.labels',
  :access_type => 'offline'}
end

