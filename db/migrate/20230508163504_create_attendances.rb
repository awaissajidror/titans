class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.string :employee_name
      t.boolean :is_present

      t.timestamps
    end
  end
end
