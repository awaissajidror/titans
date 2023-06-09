class AttendancesController < ApplicationController
  before_action :set_user, only: :mark_attendance
  def index
    response     = Attendances::CurrentWeekDaysService.call(params[:search])
    @data        = response[:data]&.sort_by { |attendance| attendance.attendance_date }
    @attendances = response[:days].uniq.sort_by { |date_string| Date.strptime(date_string.split(',')[1], '%d-%m-%Y') }
    @users       = list_users
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

  def list_users
    if params[:search].present? && params[:search][:role] == 'Labour'
      User.labours.paginate(page: params[:page], per_page: 15).order('id ASC')
    elsif params[:search].present? && params[:search][:role] == 'Office worker'
      User.office_workers.paginate(page: params[:page], per_page: 15).order('id ASC')
    else
      User.labour_workers.paginate(page: params[:page], per_page: 15).order('id ASC')
    end
  end
end
