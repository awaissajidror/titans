class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.string :employee_name
      t.date :attendance_date
      t.boolean :is_absent, default: false
      t.boolean :is_present, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
