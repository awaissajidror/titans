class HomesController < ApplicationController
  def index
    @recent_movement   = []
    @cards             = %w[Cash EFT Card Refund].freeze
    @this_month_cash   = CashUp.where('extract(year from created_at) = ? AND extract(month from created_at) = ?',
                                      Time.zone.now.year, Time.zone.now.month).sum('cash::float')
    @this_month_eft    = CashUp.where('extract(year from created_at) = ? AND extract(month from created_at) = ?',
                                      Time.zone.now.year, Time.zone.now.month).sum('eft::float')
    @this_month_card   = CashUp.where('extract(year from created_at) = ? AND extract(month from created_at) = ?',
                                      Time.zone.now.year, Time.zone.now.month).sum('card::float')
    @this_month_refund = CashUp.where('extract(year from created_at) = ? AND extract(month from created_at) = ?',
                                      Time.zone.now.year, Time.zone.now.month).sum('refund::float')

    group_by_data      = CashUp.this_year.group_by { |cashup| cashup.created_at.beginning_of_month }.sort.to_h
    group_by_data.each do |date, cash_ups|
      @recent_movement.push({
                              month: date.strftime('%b'),
                              sales: cash_ups.sum(&:cash)+
                                     cash_ups.sum(&:card) +
                                     cash_ups.sum(&:eft)
                            })
    end
  end
end
