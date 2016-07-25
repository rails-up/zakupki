require 'acceptance_helper'

feature 'Search purchases' do
  given!(:purchases) { create_list(:purchase, 2) }
  given!(:purchase) { create(:purchase) }

  before do
    purchases
    visit purchases_path
  end

  scenario 'by name', js: true do
    fill_in 'grid_f_name', with: purchase.name
    click_on 'search'
    expect(page).to have_link(purchase.name)
    expect(page).to_not have_link(purchases.first.name)
  end
end
