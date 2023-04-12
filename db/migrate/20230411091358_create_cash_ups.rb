class CreateCashUps < ActiveRecord::Migration[6.1]
  def change
    create_table :cash_ups do |t|
      t.text :note
      t.float :eft
      t.float :cash
      t.float :card
      t.float :total
      t.float :refund
      t.string :sub_total

      t.timestamps
    end
  end
end
