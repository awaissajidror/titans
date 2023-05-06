class CreateCashUps < ActiveRecord::Migration[6.1]
  def change
    create_table :cash_ups do |t|
      t.text :note,         default: ''
      t.string :sub_total,  default: ''
      t.date :cash_up_date, default: ''
      t.float :eft,         default: 0.0
      t.float :cash,        default: 0.0
      t.float :card,        default: 0.0
      t.float :total,       default: 0.0
      t.float :refund,      default: 0.0

      t.timestamps
    end
  end
end
