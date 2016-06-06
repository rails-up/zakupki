module PurchasesHelper
  class TogglePurchaseButton
    attr_accessor :text, :parameter

    def initialize(joined)
      if joined
        @text = 'purchase.leave'
        @parameter = 'leave'
      else
        @text = 'purchase.join'
        @parameter = 'join'
      end
    end
  end

  def toggle_purchase_btn(purchase)
    btn = TogglePurchaseButton.new(current_user.joined_purchase?(purchase))
    link_to(I18n.t(btn.text), toggle_purchase_path(purchase, toggle_purchase: btn.parameter),
            class: "waves-effect waves-light btn", method: :post)
  end
end
