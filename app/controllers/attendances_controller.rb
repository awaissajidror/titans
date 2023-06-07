class AttendancesController < ApplicationController
  before_action :set_user, only: :mark_attendance
  def index
    response = Attendances::CurrentWeekDaysService.call(params[:search])
    @attendances = response[:days].uniq
    @data        = response[:data]
    @users       = User.employees.paginate(page: params[:page], per_page: 15).order('id ASC')
  end

  def process_report
    if params[:csv_report].present?
      response = Attendances::CsvReportService.call(params[:attendances])

      send_data response, filename: "#{Date.today.strftime('%B')}.csv", disposition: :attachment
    else
      response = CashUps::SpReportService.call(params[:attendances])

      redirect_to sp_report_cash_ups_url(response)
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
