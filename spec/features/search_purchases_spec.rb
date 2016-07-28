require 'acceptance_helper'

feature 'Search purchases' do
  given!(:city) { create(:city) }
  given!(:group) { create(:group, enabled: true) }
  given!(:purchases) { create_list(:purchase, 2, group: create(:group, enabled: true)) }
  given!(:purchase) { create(:purchase, group: group, city: city) }
  given!(:purchase_without_group) { create(:purchase, group: nil) }

  before do 
    visit purchases_path 
  end

  scenario 'by name', js: true do
    fill_in 'grid_f_name', with: purchase.name
    search

    within '.wice-grid tbody' do
      expect(page).to have_content(purchase.name)
      expect(page).to_not have_content(purchases.last.name)
    end
  end

  scenario 'by city name', js: true do
    fill_in 'grid_f_cities_name', with: city.name
    search

    within '.wice-grid tbody' do
      expect(page).to have_content(city.name)
      expect(page).to_not have_content(purchases.last.city.name)
    end
  end

  context 'by group' do
    scenario 'when purchase has group', js: true do
      select purchase.group.name, from: 'grid_f_groups_id'
      search

      within '.wice-grid tbody' do
        expect(page).to have_content(purchase.group.name)
        expect(page).to_not have_content(purchases.last.group.name)
      end
    end

    scenario 'when purchase without group', js: true do
      select I18n.t('group.non_exist'), from: 'grid_f_groups_id'
      search

      within '.wice-grid tbody' do
        expect(page).to have_content(purchase_without_group.name)
        expect(page).to_not have_content(purchases.last.group.name)
      end
    end
  end

  def search
    page.evaluate_script("$('form').submit()")
  end
end
