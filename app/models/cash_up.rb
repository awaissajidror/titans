class CashUp < ApplicationRecord
  scope :this_year, -> { where("extract(year from created_at) = ?", Time.zone.now.year) }
  scope :between, ->(start_date, end_date) { where(created_at: start_date..end_date) }
end
