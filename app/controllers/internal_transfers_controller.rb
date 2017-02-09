class InternalTransfersController < ApplicationController
  def new
    @transfer = FidorApi::Transfer::Internal.new
  end

  def create
    @transfer = FidorApi::Transfer::Internal.new(transfer_params)
    @transfer.account_id   = current_account.id
    @transfer.external_uid = SecureRandom.hex(8)

    if @transfer.valid? && @transfer.save
      redirect_to internal_transfer_path(@transfer.id), flash: { success: "Transfer has been successfully created" }
    else
      render :new
    end
  end

  def show
    @transfer = FidorApi::Transfer::Internal.find(params[:id])
  end

  private

  def transfer_params
    params.require(:transfer_internal).permit(:receiver, :amount, :subject).tap do |params|
      params[:amount] = params[:amount].present? ? BigDecimal.new(params[:amount]) : nil
    end
  end
end
