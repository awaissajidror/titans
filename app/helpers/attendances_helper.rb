module AttendancesHelper

  def present_marked(user, day)
    user.attendances.current_week.current_attendance(day)&.last&.is_present
  end

  def absent_marked(user, day)
    user.attendances.current_week.current_attendance(day)&.last&.is_absent
  end
end
