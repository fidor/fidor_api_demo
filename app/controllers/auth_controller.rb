class AuthController < ApplicationController
  def new
    redirect_to FidorApi::Auth.authorize_url
  end

  def callback
    session[:api_token] = FidorApi::Auth.fetch_token params[:code]
    redirect_to root_path
  end

  def remove
    session.delete(:api_token)
    redirect_to root_path
  end
end
