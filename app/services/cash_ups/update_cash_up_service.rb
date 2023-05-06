module CashUps
  class UpdateCashUpService < BaseService
    def initialize(cash_up, params)
      @params  = params
      @cash_up = cash_up
    end

    def call
      @cash_up.update(@params)
    end

    private

    attr_reader :cash_up, :params
  end
end
