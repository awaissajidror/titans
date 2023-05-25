module CashUps
  class CreateCashUpService < BaseService
    def initialize(params)
      @params = params
    end

    def call
      cash_up = CashUp.new(@params)
      cash_up.save
    end

    private

    attr_reader :params
  end
end