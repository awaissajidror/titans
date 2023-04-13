class HomesController < ApplicationController
  def index
    @cards             = %w[Cash EFT Card Refund].freeze
    @this_month_cash   = CashUp.where("extract(year from created_at) = ? AND extract(month from created_at) = ?",
                                      Time.zone.now.year, Time.zone.now.month).sum(:cash)
    @this_month_eft    = CashUp.where("extract(year from created_at) = ? AND extract(month from created_at) = ?",
                                      Time.zone.now.year, Time.zone.now.month).sum(:eft)
    @this_month_card   = CashUp.where("extract(year from created_at) = ? AND extract(month from created_at) = ?",
                                      Time.zone.now.year, Time.zone.now.month).sum(:card)
    @this_month_refund = CashUp.where("extract(year from created_at) = ? AND extract(month from created_at) = ?",
                                      Time.zone.now.year, Time.zone.now.month).sum(:refund)

    this_year_cash_ups = CashUp.where("extract(year from created_at) = ?", Time.zone.now.year)
    group_by_data      = this_year_cash_ups.group_by { |cashup| cashup.created_at.beginning_of_month }.sort.to_h
    @results = []
    group_by_data.each do |date, cash_ups|
      @results << { month: date.strftime('%b'), sales:  cash_ups.sum(&:cash) + cash_ups.sum(&:card) + cash_ups.sum(&:eft)}
    end
    binding.pry
  end
end
