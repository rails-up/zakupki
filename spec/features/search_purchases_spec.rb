require 'acceptance_helper'

feature 'Search purchases' do
  given!(:city) { create(:city, name: 'Moscow') }
  given!(:group) { create(:group, enabled: true) }
  given!(:purchases) { create_list(:purchase, 2, group: create(:group, enabled: true)) }
  given!(:purchase) { create(:purchase, city: city) }
  given!(:purchase_without_group) { create(:purchase, group: nil) }

  after { Capybara.reset_sessions! }

  before do
    visit purchases_path
  end

  scenario 'by name', js: true do
    fill_in 'grid_f_name', with: purchase.name
    click_on 'search'
    expect(page).to have_link(purchase.name)
    expect(page).to_not have_link(purchases.first.name)
  end

  scenario 'by city name', js: true do
    fill_in 'grid_f_cities_name', with: city.name
    click_on 'search'
    expect(page).to have_content(city.name)
    expect(page).to_not have_link(purchases.first.city.name)
  end

  context 'by group' do
    scenario 'when purchase has group', js: true do
      select group.name, from: 'grid_f_groups_id'
      click_on 'search'
      expect(page).to have_content(group.name)
      expect(page).to_not have_link(purchases.first.group.name)
    end

    scenario 'when purchase without group', js: true do
      select I18n.t('group.non_exist'), from: 'grid_f_groups_id'
      click_on 'search'
      expect(page).to have_content(purchase_without_group.name)
      expect(page).to_not have_link(purchases.first.group.name)
    end
  end
end
