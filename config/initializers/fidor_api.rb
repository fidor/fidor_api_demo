Rails.application.config.x.tap do |config|
  config.fidor_api.environment   = (ENV['FIDOR_API_ENVIRONMENT'] || 'FidorApi::Environment::FidorDE::Sandbox').constantize.new
  config.fidor_api.client_id     = ENV['FIDOR_API_CLIENT_ID']
  config.fidor_api.client_secret = ENV['FIDOR_API_CLIENT_SECRET']
  config.fidor_api.callback_url  = ENV['FIDOR_API_CALLBACK']
end
