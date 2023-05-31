module CashUps
  class SpReportService < BaseService
    def initialize(cash_ups)
      @cash_ups = cash_ups
    end

    def call
      parsed_response = JSON.parse(cash_ups)
      total_eft       = parsed_response.map { |hash| hash['eft'].to_f }.sum
      total_cash      = parsed_response.map { |hash| hash['cash'].to_f }.sum
      total_card      = parsed_response.map { |hash| hash['card'].to_f }.sum
      total           = parsed_response.map { |hash| hash['total'].to_f }.sum
      total_refund    = parsed_response.map { |hash| hash['refund'].to_f }.sum
      total_sub       = "#{total_cash + total_card + total_eft} - #{total_refund}"
      month           = Date.parse(parsed_response.last['cash_up_date']).strftime('%B')

      {
        total_eft: total_eft,
        total_cash: total_cash,
        total_card: total_card,
        total: total,
        total_refund: total_refund,
        total_sub: total_sub, month: month
      }
    end

    private

    attr_reader :cash_ups
  end
end