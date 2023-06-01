module Attendances
  class CurrentWeekDaysService < BaseService
    def initialize(search)
      @search = search
    end

    def call
      if search.present?
        attendances = Array.new
        days        = Array.new
        week        = search[:week]
        month       = search[:month]

        start_date  = Date.parse(month.to_s).beginning_of_month
        end_date    = start_date.end_of_month

        if search[:week].present?
          User.employees.each do |user|
            start_date = Date.parse("#{week} #{month}").beginning_of_month + (week.to_i - 1) * 7
            end_date   = start_date + 6

            user.attendances.where(attendance_date: start_date..end_date).each do |attendance|
              attendances << attendance
            end
          end
        else
          User.employees.each do |user|
            user.attendances.where(attendance_date: start_date..end_date).each do |attendance|
              attendances << attendance
            end
          end
        end

        attendances

        (attendances).each do |attendance|
          next if attendance.attendance_date.sunday?
          days << "#{attendance.attendance_date.strftime('%A,%d-%m-%Y')}"
        end

        days

        { data: attendances, days: days }
      else
        days          = Array.new
        today         = Date.today
        start_of_week = today - today.wday
        end_of_week   = start_of_week + 6

        (start_of_week..end_of_week).each do |date|
          next if date.sunday?
          days << "#{date.strftime('%A,%d-%m-%Y')}"
        end

        { data: nil, days: days }
      end
    end


    private

    attr_reader :search
  end
end