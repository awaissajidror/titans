module CashUps
  class CreateCashUpService < BaseService
    def initialize(params)
      @params = params
    end

    def call
      cash_up   = CashUp.new(@params)

      sum       = cash_up.cash + cash_up.card + cash_up.eft
      sub_total = sum - cash_up.refund

      cash_up.sub_total = set_sub_string(sum, cash_up.refund)
      cash_up.total = sub_total

      cash_up.save
    end

    private

    attr_reader :params

    def set_sub_string(sum, refund)
      return "#{sum} - #{refund}" if refund.present? && refund > 0.0

      sum
    end
  end
end