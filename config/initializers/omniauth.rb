# frozen_string_literal: true

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :google_oauth2, Secret['GOOGLE_CLIENT_ID'], Secret['GOOGLE_CLIENT_SECRET']
end
