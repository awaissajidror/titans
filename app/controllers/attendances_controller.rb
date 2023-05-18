class AttendancesController < ApplicationController

  def index
    @users = User.employees.paginate(page: params[:page], per_page: 15).order('id DESC')
  end

  def mark_attendance
    user = User.find(params[:user_id])
    attendance = user.attendances.where("DATE(created_at) = ?", Date.today).last
    if attendance.present?
      attendance.update(is_present: ActiveRecord::Type::Boolean.new.cast(params[:attendance]))
    else
      Attendance.create(user_id: user.id, is_present: ActiveRecord::Type::Boolean.new.cast(params[:checked]), employee_name: user.name)
    end
  end

end
