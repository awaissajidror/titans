module CashUps
  class FilterCashUpsService < BaseService
    def initialize(month)
      @month = month
    end

    def call
      if month.present?
        month_number = Date::MONTHNAMES.index(month)
        start_date   = DateTime.new(Date.current.year, month_number, 1)
        end_date     = start_date.end_of_month

        CashUp.between(start_date, end_date)
      else
        start_date = Time.zone.now.beginning_of_month
        end_date   = Time.zone.now.end_of_month

        CashUp.between(start_date, end_date)
      end
    end

    private

    attr_reader :month
  end
end