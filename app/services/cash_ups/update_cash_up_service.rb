module CashUps
  class UpdateCashUpService < BaseService
    def initialize(cash_up, params)
      @params  = params
      @cash_up = cash_up
    end

    def call
      cash_up.update(params)
    end

    private

    attr_reader :cash_up, :params

    def set_sub_string(sum, refund)
      return "#{sum} - #{refund}" if refund.present? && refund > 0.0

      sum
    end
  end
end
