module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_access_token   # never ever skip this action
    after_action  :clear_access_token # never ever skip this action

    helper_method :logged_in?
    helper_method :current_account
    helper_method :current_customer
    helper_method :current_user
  end

  private

  def set_access_token
    clear_access_token
    FidorApi::Connectivity.access_token = api_token&.access_token
  end

  def clear_access_token
    FidorApi::Connectivity.access_token = nil
  end

  def require_valid_session
    unless logged_in?
      session[:forward] = request.original_url
      redirect_to login_path
    end
  end

  def logged_in?
    api_token&.valid?
  end

  def api_token
    @api_token ||= begin
      return unless session[:api_token].present?
      token = FidorApi::Token.new session[:api_token]
      token = FidorApi::Auth.refresh_token(token) unless token.valid?
      token
    end
  end

  def current_account
    return unless logged_in?
    @current_account ||= FidorApi::Account.first
  end

  def current_customer
    return unless current_account
    @current_customer ||= current_account.customers.first
  end

  def current_user
    return unless logged_in?
    @current_user ||= FidorApi::User.current
  end
end