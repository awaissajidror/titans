module CashUpsHelper

  def set_value(value)
    return value if value.present?

    0.00
  end
end
