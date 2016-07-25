require 'acceptance_helper'

feature 'Search purchases' do
  given!(:city) { create(:city, name: 'Moscow') }
  given!(:group) { create(:group, city: city) }
  given!(:purchases) { create_list(:purchase, 2) }
  given!(:purchase) { create(:purchase, group: group) }

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

  scenario 'by city name', js: true do
    fill_in 'grid_f_name', with: city.name
    click_on 'search'
    expect(page).to have_content(city.name)
    expect(page).to_not have_link(purchases.first.city.name)
  end
end
