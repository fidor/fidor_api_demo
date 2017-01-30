class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_complete_setup

  private

  def require_complete_setup
    redirect_to setup_configs_path if EnvConfig.incomplete?
  end
end
