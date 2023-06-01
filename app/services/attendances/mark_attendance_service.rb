module Attendances
  class MarkAttendanceService < BaseService
    def initialize(user, params)
      @user   = user
      @params = params
    end

    def call
      attendance_date = Date.parse(params[:attendance_date].to_s)
      attendance      = user.attendances.where("DATE(attendance_date) = ?", attendance_date).last
      if attendance.present?
        case params[:status]
        when 'present'
          attendance.update(is_present: ActiveRecord::Type::Boolean.new.cast(params[:checked]))
        else
          attendance.update(is_absent: ActiveRecord::Type::Boolean.new.cast(params[:checked]))
        end
      else
        case params[:status]
        when 'present'
          Attendance.create(
            employee_name: user.name, attendance_date: attendance_date, is_absent: false,
            is_present: ActiveRecord::Type::Boolean.new.cast(params[:checked]), user_id: user.id
          )
        else
          Attendance.create(
            employee_name: user.name, attendance_date: attendance_date, is_present: false,
            is_absent: ActiveRecord::Type::Boolean.new.cast(params[:checked]), user_id: user.id
          )
        end
      end
    end

    private

    attr_reader :user, :params
  end
end