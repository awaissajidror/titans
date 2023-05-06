module CashUps
  class FilterCashUpsService < BaseService
    def initialize(month, page)
      @page  = page
      @month = month
    end

    def call
      if month.present?
        month_number = Date::MONTHNAMES.index(month)
        start_date   = DateTime.new(Date.current.year, month_number, 1)
        end_date     = start_date.end_of_month

        CashUp.between(start_date, end_date).paginate(page: page, per_page: 15).order('id DESC')
      else
        start_date = Time.zone.now.beginning_of_month
        end_date   = Time.zone.now.end_of_month

        CashUp.between(start_date, end_date).paginate(page: page, per_page: 15).order('id DESC')
      end
    end

    private

    attr_reader :month, :page
  end
end