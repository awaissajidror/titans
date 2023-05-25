class ChangeColumnToCashUp < ActiveRecord::Migration[6.1]
  def change
    change_column(:cash_ups, :eft, :string, default: '')
    change_column(:cash_ups, :cash, :string, default: '')
    change_column(:cash_ups, :card, :string, default: '')
    change_column(:cash_ups, :total, :string, default: '')
    change_column(:cash_ups, :refund, :string, default: '')
  end
end
