module CashUpsHelper

  def set_value(value)
    return value if value.present?

    show_value(value)
  end

  private

  def show_value(value)
    params[:action].to_sym == :show ? value : 0.00
  end
end
