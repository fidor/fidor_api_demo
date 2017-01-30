class Setup::ConfigsController < ApplicationController
  skip_before_action :require_complete_setup

  def index
  end
end
