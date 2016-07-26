require 'rails_helper'

feature 'List purchases' do
  given!(:purchases) { create_list(:purchase, 3) }

  scenario 'sees all purchases' do
    visit purchases_path

    purchases.each do |purchase|
      purchase_content(purchase)
    end

    expect(page).to have_css('.wice-grid')
  end

  scenario 'can view purchase details when click on it' do
    purchase = create :purchase

    visit purchases_path

    click_link(purchase.name)

    expect(page).to have_content(purchase.name)
    expect(page).to have_content(purchase.description)
    expect(page).to have_content(I18n.l purchase.end_date, format: :long)
  end

  context 'when user signed in'  do
    scenario 'can create new purchase' do
      user = create :user, :organizer
      login_as user

      visit purchases_path
      click_link I18n.t('purchase.new')
      fill_in 'purchase[name]', with: 'New purchase name'
      fill_in 'purchase[description]', with: 'Some description'
      fill_in 'purchase[end_date]', with: Time.current + 5.days
      find("input[name='commit']").click

      # expect(page).to have_content("New purchase name")
      expect(page).to have_content('Some description')
    end
  end

  context 'when user not signed in' do
    scenario "can't create new purchase" do
      visit purchases_path

      expect(page).to_not have_link(I18n.t('purchase.new'), new_purchase_path)
    end
  end
end

def purchase_content(purchase)
  expect(page).to have_content(purchase.name)
  expect(page).to have_content(purchase.end_date)
  expect(page).to have_content(purchase.city.name)
end
