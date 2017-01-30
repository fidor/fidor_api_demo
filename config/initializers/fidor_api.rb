FidorApi.configure do |config|
  config.oauth_url       = ENV["FIDOR_OAUTH_URL"]
  config.api_url         = ENV["FIDOR_API_URL"]
  config.api_path        = ENV["FIDOR_API_PATH"]
  config.callback_url    = ENV["FIDOR_API_CALLBACK"]
  config.client_id       = ENV["FIDOR_API_CLIENT_ID"]
  config.client_secret   = ENV["FIDOR_API_CLIENT_SECRET"]
  config.htauth_user     = ENV["FIDOR_API_HTAUTH_USER"]
  config.htauth_password = ENV["FIDOR_API_HTAUTH_PASSWORD"]
  config.affiliate_uid   = ENV["FIDOR_API_AFFILIATE_UID"]
  config.logging         = ENV["FIDOR_API_LOGGING"] == "true"
  config.logger          = TaggedLogger.new("FidorApi", Rails.logger)
  config.verify_ssl      = ENV.fetch("FIDOR_API_VERIFY_SSL", "true") == "true"
end
