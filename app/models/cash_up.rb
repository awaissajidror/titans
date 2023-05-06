class CashUp < ApplicationRecord
  attribute :cash_up_date, :date, default: -> { Time.zone.now }

  # Custom Queries
  scope :this_year, -> { where("extract(year from created_at) = ?", Time.zone.now.year) }
  scope :between, ->(start_date, end_date) { where(cash_up_date: start_date..end_date) }
end
