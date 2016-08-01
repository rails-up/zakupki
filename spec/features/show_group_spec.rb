require 'rails_helper'

feature 'Viewing group' do
  given!(:group) { create(:group, enabled: true) }
  given!(:group_without_purchases) { create(:group, enabled: true) }
  given!(:purchases) { create_list(:purchase, 2, group: group) }

  scenario 'main info' do
    visit groups_path
    find(:xpath, "//a[@href='/groups/#{group.id}']").click

    expect(page).to have_content(group.name)
    expect(page).to have_content(group.description)
  end

  scenario  'with purchases' do
    visit group_path(group)
    expect(page).to have_content(I18n.t('group.active_purhcases'))

    purchases.each do |purchase|
      expect(page).to have_content(purchase.name)
      expect(page).to have_content(purchase.description)
      expect(page).to have_content(purchase.end_date.strftime("%d.%m.%Y"))
    end
  end

  scenario 'without purchases' do
    visit group_path(group_without_purchases)
    expect(page).to_not have_content(I18n.t('group.active_purhcases'))
  end
end
