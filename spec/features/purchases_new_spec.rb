require 'rails_helper'

RSpec.feature 'Adding purchase' do
  scenario 'sees ckeditor for description' do
    user = create :user, :organizer
    login_as user
    purchase = build(:purchase)

    visit new_purchase_path(purchase)

    expect(page).to have_css('#purchase_description')
  end

  context 'Organizer' do
    scenario 'create purchase' do
      user = create :user, :organizer
      login_as user
      purchase = build(:purchase)

      visit new_purchase_path(purchase)

      fill_in 'purchase_name', with: 'Purchase name'
      fill_in 'purchase_description', with: 'Purchase description'

      select find('#purchase_status option:first').text, from: 'purchase_status'
      select find('#purchase_city_id option:first').text, from: 'purchase_city_id'
      select find('#purchase_group_id option:first').text, from: 'purchase_group_id'

      fill_in 'purchase_catalogue_link', with: 'http://test.link'
      fill_in 'purchase_commission', with: 9.9

      fill_in 'purchase_end_date', with: DateTime.now.strftime("%Y/%m/%d")

      fill_in 'purchase_address', with: 'Test address'
      fill_in 'purchase_apartment', with: 'Test apartment'

      find("#purchase_delivery_payment_type_id_#{purchase.delivery_payment_type.id}").set(true)
      find("#purchase_delivery_payment_cost_type_id_#{purchase.delivery_payment_cost_type.id}").set(true)

      click_on 'Сохранить'

      expect(current_path).to eq purchases_path
      expect(page).to have_content('Purchase name')
    end
  end
end
