class InternalTransfersController < ApplicationController
  before_action :require_valid_session

  def new
    @transfer = fidor_api.new_internal_transfer
  end

  def create
    if (@transfer = fidor_api.create_internal_transfer(transfer_params)) && @transfer.persisted?
      redirect_to internal_transfer_path(@transfer.id), flash: { success: "Transfer has been successfully created" }
    else
      render :new
    end
  end

  def show
    @transfer = fidor_api.internal_transfer(params[:id])
  end

  private

  def transfer_params
    params.require(:transfer_internal).permit(:receiver, :amount, :subject).tap do |params|
      params[:amount]       = params[:amount].present? ? BigDecimal.new(params[:amount]) : nil
      params[:account_id]   = current_account.id
      params[:external_uid] = SecureRandom.hex(8)
    end
  end
end
