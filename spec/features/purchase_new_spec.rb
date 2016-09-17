require 'acceptance_helper'

RSpec.feature 'Adding purchase' do
  given(:delivery_payment_cost_types) { create_list(:delivery_payment_cost_type, 2) }
  given(:delivery_payment_types) { create_list(:delivery_payment_type, 2) }
  given(:cities) { create_list(:city, 2) }
  given(:groups) { create_list(:group, 2, enabled: true) }

  context 'Role organizer' do
    before { login_as create :user, :organizer }

    scenario 'create purchase', js: true do
      delivery_payment_types
      delivery_payment_cost_types
      cities
      groups

      visit new_purchase_path

      fill_purchase_form_with_valid_data

      click_on I18n.t('save')

      expect(current_path).to eq purchases_path
      expect(page).to have_content(I18n.t('purchase.created'))
    end

    scenario 'create purchase with flat_shipping_delivery', js: true  do
      delivery_payment_types
      delivery_payment_cost_types
      cities
      groups
      fix_price_delivery = create :delivery_payment_type,
                                  value: 'фиксированная стоимость'
      flat_shipping_price = '88.88'

      visit new_purchase_path

      fill_purchase_form_with_valid_data
      materialize_choose(fix_price_delivery.value)
      fill_in 'purchase[flat_shipping_price]', with: flat_shipping_price
      click_on I18n.t('save')

      expect(page).to have_content(I18n.t('purchase.created'))

      visit purchase_path(Purchase.last)

      expect(page).to have_content(fix_price_delivery.value)
      expect(page).to have_content(flat_shipping_price)
    end
  end

  context 'Role user' do
    before do
      user = create :user
      login_as user
    end

    scenario 'doesnt see new purchase button' do
      visit purchases_path
      expect(page).to_not have_content(I18n.t('purchase.new'))
    end

    scenario 'create purchase' do
      visit new_purchase_path
      expect(page).to have_content(I18n.t('unauthorized.manage.purchase'))
    end
  end

  context 'Non-authorized' do
    scenario 'doesnt see new purchase button' do
      visit purchases_path
      expect(page).to_not have_content(I18n.t('purchase.new'))
    end

    scenario 'create purchase' do
      visit new_purchase_path
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    end
  end

  def fill_purchase_form_with_valid_data
    fill_in 'purchase_name', with: 'Purchase name'
    fill_in_ckeditor 'purchase_description', with: 'Purchase description'

    select first('#purchase_status option').text, from: 'purchase_status'
    select first('#purchase_city_id option').text, from: 'purchase_city_id'
    find('#purchase_group_id').find(:xpath, 'option[2]').select_option

    fill_in 'purchase_catalogue_link', with: 'http://test.link'
    fill_in 'purchase_commission', with: 9.9

    pick_date_fill_in(DateTime.now.strftime("%Y/%m/%d"))

    fill_in 'purchase_address', with: 'Test address'
    fill_in 'purchase_apartment', with: 'Test apartment'

    materialize_choose(delivery_payment_types[0].value)
    materialize_choose(delivery_payment_cost_types[0].value)
  end
end
