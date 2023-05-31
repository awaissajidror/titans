class Attendance < ApplicationRecord

  # ActiveRecord::Relations
  belongs_to :user

  # Custom Queries
  scope :current_attendance, ->(day) { where(attendance_date: Date.parse(day)) }
  scope :current_week,       -> { where(attendance_date: Date.current.beginning_of_week..Date.current.end_of_week) }
end
