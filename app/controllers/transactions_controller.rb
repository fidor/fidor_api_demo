class TransactionsController < ApplicationController
  before_action :require_valid_session

  def index
    @transactions = fidor_api.transactions(pagination)
  end

  def show
    @transaction = fidor_api.transaction params[:id]
  end

  private

  def pagination
    {
      page:     params[:page] || 1,
      per_page: 10
    }
  end
end
