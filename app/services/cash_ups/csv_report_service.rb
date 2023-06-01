module CashUps
  class CsvReportService < BaseService
    def initialize(cash_ups)
      @cash_ups = cash_ups
    end

    def call
      require 'csv'

      parsed_response = JSON.parse(cash_ups)
      total_eft    = parsed_response.map { |hash| hash['eft'] }.reduce(:+)
      total_cash   = parsed_response.map { |hash| hash['cash'] }.reduce(:+)
      total_card   = parsed_response.map { |hash| hash['card'] }.reduce(:+)
      total        = parsed_response.map { |hash| hash['total'] }.reduce(:+)
      total_refund = parsed_response.map { |hash| hash['refund'] }.reduce(:+)
      total_sub    = "#{total_cash + total_card + total_eft} - #{total_refund}"

      CSV.generate(headers: true) do |csv|
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
    end

    private

    attr_reader :cash_ups
  end
end