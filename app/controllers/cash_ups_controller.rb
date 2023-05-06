class CashUpsController < ApplicationController
  before_action :set_cash_up, only: %i[ show edit update destroy generate_pdf ]
  include ResponseAble

  def index
    @cash_ups = CashUps::FilterCashUpsService.call(params[:month], params[:page])
  end

  def show; end

  def new
    @cash_up = CashUp.new
  end

  def edit
  end

  def create
    response = CashUps::CreateCashUpService.call(cash_up_params)
    return success_response if response

    error_response
  end

  def update
    response = CashUps::UpdateCashUpService.call(@cash_up, cash_up_params)
    return success_response if response

    error_response
  end

  def destroy
    response = CashUps::DestroyCashUpService.call(@cash_up)
    return success_response if response

    error_response
  end

  def generate_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "CashUp-PDF#{@cash_up.id}",
               page_size: 'A4',
               layout: 'pdf.html',
               template: 'cash_ups/cashup.html.erb',
               encoding: 'UTF-8'
      end
    end
  end

  def generate_sp_pdf
    month = params[:data].as_json['month']
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "CashUp-Of#{Date.parse(month).strftime('%B')}",
               page_size: 'A4',
               layout: 'pdf.html',
               template: 'cash_ups/sp.html.erb',
               encoding: 'UTF-8'
      end
    end
  end

  private

  def set_cash_up
    @cash_up = CashUp.find(params[:id])
  end

  def cash_up_params
    params.require(:cash_up).permit(:cash, :card, :eft, :sub_total, :total, :refund, :note, :cash_up_date)
  end

end
