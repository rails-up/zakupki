require 'acceptance_helper'

feature 'Search purchases' do
  given!(:city) { create(:city, name: 'Moscow') }
  given!(:group) { create(:group, enabled: true) }
  given!(:purchases) { create_list(:purchase, 2, group: create(:group, enabled: true)) }
  given!(:purchase) { create(:purchase, city: city, group: group) }
  given!(:purchase_without_group) { create(:purchase, group: nil) }

  before { visit purchases_path }

  xscenario 'by name', js: true do
    fill_in 'grid_f_name', with: purchase.name
    click_on 'search'
    wait_for_ajax
    expect(page).to have_link(purchase.name)
    expect(page).to_not have_link(purchases.first.name)
  end

  xscenario 'by city', js: true do
    fill_in 'grid_f_cities_name', with: purchases.first.city.name
    click_on 'search'
    wait_for_ajax
    expect(page).to have_link(purchases.first.name)
    expect(page).to_not have_link(purchases.last.name)
  end

  xcontext 'by group' do
    before { visit purchases_path }

    scenario 'when purchase has group', js: true do
      select purchase.group.name, from: 'grid_f_groups_id'
      click_on 'search'
      wait_for_ajax
      expect(page).to have_link(purchase.name)
      expect(page).to_not have_link(purchases.first.name)
    end

    scenario 'when purchase without group', js: true do
      select I18n.t('group.non_exist'), from: 'grid_f_groups_id'
      click_on 'search'
      wait_for_ajax
      expect(page).to have_link(purchase_without_group.name)
      expect(page).to_not have_link(purchases.first.name)
    end
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end
