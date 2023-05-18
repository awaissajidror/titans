class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :is_absent
      t.boolean :is_present
      t.string :employee_name

      t.timestamps
    end
  end
end
