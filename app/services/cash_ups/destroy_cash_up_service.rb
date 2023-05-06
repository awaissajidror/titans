module CashUps
  class DestroyCashUpService < BaseService
    def initialize(cash_up)
      @cash_up = cash_up
    end

    def call
      @cash_up.destroy
    end

    private

    attr_reader :cash_up
  end
end
