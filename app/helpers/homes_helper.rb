module HomesHelper

  def render_card_image(card)
    image_tag(image_source(card), alt: card, width: 25)
  end

  def render_amount(card)
    case card
    when 'Cash'
      @this_month_cash
    when 'EFT'
      @this_month_eft
    when 'Card'
      @this_month_card
    else
      @this_month_refund
    end
  end

  def render_badge_class(card)
    case card
    when 'Cash'
      'bg-primary'
    when 'EFT'
      'bg-success'
    when 'Card'
      'bg-secondary'
    else
      'bg-warning'
    end
  end

  private

  def image_source(card)
    case card
    when 'Cash'
      '/assets/payment-method.png'
    when 'EFT'
      '/assets/eft.png'
    when 'Card'
      '/assets/credit_card.png'
    else
      '/assets/refund.png'
    end
  end
end
