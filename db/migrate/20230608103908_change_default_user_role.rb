class ChangeDefaultUserRole < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :role, :integer, null: false, default: nil
  end
end
