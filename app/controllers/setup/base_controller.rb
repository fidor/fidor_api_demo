class Setup::BaseController < ApplicationController
  skip_before_action :require_complete_setup

  before_action :require_incomplete_setup

  def index
  end

  private

  def require_incomplete_setup
    redirect_to root_path if Rails.env.production? && !EnvConfig.incomplete?
  end

end