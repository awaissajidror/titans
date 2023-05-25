class CashUp < ApplicationRecord
  attribute :cash_up_date, :date, default: -> { Time.zone.now }

  # Custom Queries
  scope :this_year, -> { where("extract(year from created_at) = ?", Time.zone.now.year) }
  scope :between, ->(start_date, end_date) { where(cash_up_date: start_date..end_date) }

  # ActiveRecord Callbacks
  before_save :update_sub_total

  private

  def update_sub_total
    sum       = set_sprintf(self.cash) + set_sprintf(self.card) + set_sprintf(self.eft)
    sub_total = set_sprintf(sum) - set_sprintf(self.refund)

    self.sub_total = set_sub_string(set_sprintf(sum), set_sprintf(self.refund))
    self.total = sub_total
  end

  def set_sub_string(sum, refund)
    return "#{sum} - #{refund}" if refund.present? && refund > 0.0

    sum
  end

  def set_sprintf(value)
    sprintf('%.2f', value).to_f
  end
end
