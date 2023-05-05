class CashUpsController < ApplicationController
  before_action :set_cash_up, only: %i[ show edit update destroy generate_pdf ]
  after_action :populate_fields, only: %i[ create update ]

  def index
    if params[:cash_up].present? && params[:cash_up][:month].present?
      cash_ups_of_month
    elsif params[:cash_ups].present? && params[:csv_report].present?
      require 'csv'

      cash_ups        = params[:cash_ups]
      parsed_response = JSON.parse(cash_ups)
      total_eft       = parsed_response.map { |hash| hash['eft'] }.reduce(:+)
      total_cash      = parsed_response.map { |hash| hash['cash'] }.reduce(:+)
      total_card      = parsed_response.map { |hash| hash['card'] }.reduce(:+)
      total           = parsed_response.map { |hash| hash['total'] }.reduce(:+)
      total_refund    = parsed_response.map { |hash| hash['refund'] }.reduce(:+)
      total_sub       = "#{total_cash + total_card + total_eft} - #{total_refund}"

      csv_data = CSV.generate(headers: true) do |csv|
        csv << %w[Cash Card EFT Refund Note Sub-Total Total]
        parsed_response.each do |data|

          keys_to_delete = %w[id created_at updated_at]
          keys_to_delete.each { |key| data.delete(key) }
          csv << [data['cash'], data['card'], data['eft'], data['refund'], data['note'], data['sub_total'], data['total']]
        end
        csv << ['', '', '', '', '', '', '']
        csv << ['Total Cash', 'Total Card', 'Total EFT', 'Total Refund', '', 'Total Sub', 'Total']
        csv << [total_cash, total_card, total_eft, total_refund, '', total_sub, total]
      end

      send_data csv_data, filename: "#{Date.today.strftime('%B')}.csv", disposition: :attachment
    elsif params[:cash_ups].present? && params[:spr_report].present?
      cash_ups        = params[:cash_ups]
      parsed_response = JSON.parse(cash_ups)
      @total_eft       = parsed_response.map { |hash| hash['eft'] }.reduce(:+)
      @total_cash      = parsed_response.map { |hash| hash['cash'] }.reduce(:+)
      @total_card      = parsed_response.map { |hash| hash['card'] }.reduce(:+)
      @total           = parsed_response.map { |hash| hash['total'] }.reduce(:+)
      @total_refund    = parsed_response.map { |hash| hash['refund'] }.reduce(:+)
      @total_sub       = "#{@total_cash + @total_card + @total_eft} - #{@total_refund}"
      @month           = Date.parse(parsed_response.last['cash_up_date']).strftime('%B')
      redirect_to sp_report_cash_ups_url(total_eft: @total_eft, total_cash: @total_cash, total_card: @total_card,
                                         total: @total, total_refund: @total_refund, total_sub: @total_sub,
                                         month: @month)
    else
      total_cash_ups
    end
  end

  def show; end

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

  def populate_fields
    sum = @cash_up.cash + @cash_up.card + @cash_up.eft
    sub_total = sum - @cash_up.refund

    @cash_up.sub_total = set_sub_string(sum, @cash_up.refund)
    @cash_up.total = sub_total

    @cash_up.save
  end

  def set_sub_string(sum, refund)
    return "#{sum} - #{refund}" if refund.present? && refund > 0.0

    sum
  end

  def cash_up_params
    params.require(:cash_up).permit(:cash, :card, :eft, :sub_total, :total, :refund, :note, :cash_up_date)
  end

  def cash_ups_of_month
    month_number = Date::MONTHNAMES.index(params[:cash_up][:month])
    start_date   = DateTime.new(Date.current.year, month_number, 1)
    end_date     = start_date.end_of_month

    @cash_ups = CashUp.between(start_date, end_date)
                      .paginate(page: params[:page], per_page: 15)
                      .order('id DESC')
  end

  def total_cash_ups
    @cash_ups = CashUp.paginate(page: params[:page], per_page: 15)
                      .order('id DESC')
  end
end
