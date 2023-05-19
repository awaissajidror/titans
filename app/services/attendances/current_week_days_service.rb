module Attendances
  class CurrentWeekDaysService < BaseService
    def initialize
      super
    end

    def call
      days          = Array.new
      today         = Date.today
      start_of_week = today - today.wday
      end_of_week   = start_of_week + 6

      (start_of_week..end_of_week).each do |date|
        next if date.sunday?
        days << "#{date.strftime('%A,%d-%m-%Y')}"
      end

      days
    end
  end
end