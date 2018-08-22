class AuthController < ApplicationController
  def new
    redirect_to fidor_api.authorize_start(
      redirect_uri: Rails.application.config.x.fidor_api.callback_url
    )
  end

  def callback
    session[:fidor_api_token] = fidor_api.authorize_complete(
      redirect_uri: Rails.application.config.x.fidor_api.callback_url,
      code:         params[:code]
    ).to_h

    redirect_to root_path
  end

  def remove
    session.delete(:fidor_api_token)
    redirect_to root_path
  end
end
