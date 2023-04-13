class CashUp < ApplicationRecord
  scope :this_year, -> { where("extract(year from created_at) = ?", Time.zone.now.year) }
end
