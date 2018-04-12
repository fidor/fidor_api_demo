class ApplicationController < ActionController::Base
  before_action :require_complete_setup

  include Authentication

  private

  def require_complete_setup
    redirect_to setup_config_path if EnvConfig.incomplete?
  end
end
