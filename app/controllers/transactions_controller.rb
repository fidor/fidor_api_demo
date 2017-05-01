class TransactionsController < ApplicationController
  before_action :require_valid_session

  def index
    transactions = FidorApi::Transaction.all(pagination)
    @transactions = transactions
  end

  private

  def pagination
    {
      page:     params[:page] || 1,
      per_page: 10
    }
  end
end
