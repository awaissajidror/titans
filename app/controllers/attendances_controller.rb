class AttendancesController < ApplicationController

  def index
    @attendances = Attendances::CurrentWeekDaysService.call(params[:search])
    @users       = User.employees.paginate(page: params[:page], per_page: 15).order('id ASC')
  end

  def generate_report
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Attendance-PDF-#{Date.today.strftime('%m-%d-%Y')}",
               page_size: 'A4',
               layout: 'pdf.html',
               template: 'attendances/attendance_pdf',
               encoding: 'UTF-8'
      end
    end
  end

  def mark_attendance
    attendance_date = Date.parse(params[:attendance_date].to_s)
    user = User.find(params[:user_id])
    attendance = user.attendances.where("DATE(attendance_date) = ?", attendance_date).last
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

end
