module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :logged_in?
    helper_method :current_account
    helper_method :current_customer
    helper_method :current_user
  end

  def self.included(base)
    base.rescue_from Faraday::ClientError do |e|
      raise e if e.response[:status] != 401
      redirect_to logout_path
    end
  end

  private

  def require_valid_session
    unless logged_in?
      session[:forward] = request.original_url
      redirect_to login_path
    end
  end

  def logged_in?
    session[:fidor_api_token].present?
  end

  def current_account
    @current_account ||= fidor_api.accounts.first
  end

  def current_customer
    @current_customer ||= fidor_api.customers.first
  end

  def current_user
    @current_user ||= fidor_api.user
  end

  private

  def fidor_api
    client = FidorApi::Client.new do |config|
      config.environment   = Rails.application.config.x.fidor_api.environment
      config.client_id     = Rails.application.config.x.fidor_api.client_id
      config.client_secret = Rails.application.config.x.fidor_api.client_secret
      config.logger        = TaggedLogger.new("FidorApi", Rails.logger)
    end

    client.token = FidorApi::Token.new(session[:fidor_api_token]) if logged_in?
    client
  end
end
