module AttendancesHelper

  def check_present(user)
    flag = nil
    @current_week.each do |date|
      flag = true if user.attendances.where(attendance_date: Date.parse(date.split(',').last))&.last&.is_present
    end

    flag
  end
end
