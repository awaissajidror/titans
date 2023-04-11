class CashUpsController < ApplicationController
  before_action :set_cash_up, only: %i[ show edit update destroy ]

  def index
    @cash_ups = CashUp.paginate(page: params[:page], per_page: 15).order('id DESC')
  end

  def show
  end

  def new
    @cash_up = CashUp.new
  end

  def edit
  end

  def create
    @cash_up = CashUp.new(cash_up_params)
    @cash_up.save
    flash[:success] = 'CashUp Added Successfully!'
    redirect_to cash_ups_url
  end

  def update
    @cash_up.update(cash_up_params)
    flash[:success] = 'CashUp Updated Successfully!'
    redirect_to cash_ups_url
  end

  def destroy
    @cash_up.destroy
    redirect_to cash_ups_url
  end

  private

  def set_cash_up
    @cash_up = CashUp.find(params[:id])
  end

  def cash_up_params
    params.require(:cash_up).permit(:cash, :card, :eft, :sub, :total, :note)
  end
end
