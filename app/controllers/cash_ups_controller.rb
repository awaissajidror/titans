class CashUpsController < ApplicationController
  before_action :set_cash_up, only: %i[ show edit update destroy generate_pdf ]
  include ResponseAble

  def index
    if params[:cash_ups].present? && params[:cash_ups][:month].present?
      @cash_ups = cash_ups_of_month
    elsif params[:cash_ups].present? && params[:csv_report].present?
      response = CashUps::CsvReportService.call(params[:cash_ups])
      send_data response, filename: "#{Date.today.strftime('%B')}.csv", disposition: :attachment
    elsif params[:cash_ups].present? && params[:spr_report].present?
      response = CashUps::CsvReportService.call(params[:cash_ups])
      redirect_to sp_report_cash_ups_url(response)
    else
      @cash_ups = total_cash_ups
    end
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

  def cash_ups_of_month
    month_number = Date::MONTHNAMES.index(params[:cash_ups][:month])
    start_date = DateTime.new(Date.current.year, month_number, 1)
    end_date = start_date.end_of_month

    CashUp.between(start_date, end_date).paginate(page: params[:page], per_page: 15).order('id DESC')
  end

  def total_cash_ups
    CashUp.paginate(page: params[:page], per_page: 15).order('id DESC')
  end
end
