class CreateCashUps < ActiveRecord::Migration[6.1]
  def change
    create_table :cash_ups do |t|
      t.float :cash
      t.float :card
      t.float :eft
      t.float :sub
      t.float :total
      t.text :note

      t.timestamps
    end
  end
end
