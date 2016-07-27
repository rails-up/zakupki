require 'acceptance_helper'

feature 'Purchase editing' do
  given(:user) { create(:user) }
  given(:purchase) { create(:purchase, owner: user) }

  context 'Non-authenticated user' do
    scenario 'user try to edit purchase' do
      visit purchase_path(purchase)
      expect(page).to_not have_icon edit_purchase_path(purchase)
    end
  end

  context 'Authenticated user' do
    before do
      login_as user
      visit purchase_path(purchase)
    end

    scenario 'sees link to edit purchase' do
      visit purchase_path(purchase)
      expect(page).to have_icon edit_purchase_path(purchase)
    end
  end

  def have_icon href
    have_link(nil, href: href)
  end
end
