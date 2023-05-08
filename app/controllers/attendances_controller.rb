class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ edit update destroy ]

  def index
    @users = User.employees.paginate(page: params[:page], per_page: 15).order('id DESC')
    # @attendances = Attendance.all
  end

  def show
    @employee    = User.find(params[:id])
    @attendances = @employee.attendances

    require 'date'

    @dates_by_month = {}
    year            = Date.today.year
    start_date      = Date.new(year, 1, 1)
    end_date        = Date.new(year, 12, 31)

    # Group all dates by month
    (start_date..end_date).each do |date|
      month = Date::MONTHNAMES[date.month]
      @dates_by_month[month] ||= []
      @dates_by_month[month] << date
    end
  end

  def new
    @attendance = Attendance.new
  end

  def edit
  end

  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully created." }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully updated." }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url, notice: "Attendance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:user_id, :employee_name, :is_present)
  end
end
