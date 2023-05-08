json.extract! attendance, :id, :user_id, :employee_name, :is_present, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
