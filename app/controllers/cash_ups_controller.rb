class CashUpsController < ApplicationController
  before_action :set_cash_up, only: %i[ show edit update destroy generate_pdf ]
  after_action :populate_fields, only: %i[ create update ]

  def index
    @cash_ups = CashUp.paginate(page: params[:page], per_page: 15).order('id DESC')
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
    params.require(:cash_up).permit(:cash, :card, :eft, :sub_total, :total, :refund, :note)
  end
end
