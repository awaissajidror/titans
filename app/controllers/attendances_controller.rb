class AttendancesController < ApplicationController
  before_action :set_user, only: :mark_attendance
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
    Attendances::MarkAttendanceService.call(@user, params)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
