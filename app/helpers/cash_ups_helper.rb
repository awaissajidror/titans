module CashUpsHelper

  def set_value(value)
    return value if value.present? && value != ''

    show_value(value)
  end

  private

  def show_value(value)
    params[:action].to_sym == :show ? value : ''
  end
end
