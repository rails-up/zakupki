require 'acceptance_helper'

RSpec.feature 'Adding purchase' do
  let!(:delivery_payment_cost_types) { create_list(:delivery_payment_cost_type, 2) }
  let!(:delivery_payment_types) { create_list(:delivery_payment_type, 2) }
  let!(:cities) { create_list(:city, 2) }
  let!(:groups) { create_list(:group, 2, enabled: true) }

  context 'Role organizer' do
    scenario 'create purchase' do
      user = create :user, :organizer
      login_as user

      prepare_new_purchase
      visit new_purchase_path

      fill_in 'purchase_name', with: 'Purchase name'
      fill_in 'purchase_description', with: 'Purchase description'

      select first('#purchase_status option').text, from: 'purchase_status'
      select first('#purchase_city_id option').text, from: 'purchase_city_id'
      find('#purchase_group_id').find(:xpath, 'option[2]').select_option

      fill_in 'purchase_catalogue_link', with: 'http://test.link'
      fill_in 'purchase_commission', with: 9.9

      fill_in 'purchase_end_date', with: DateTime.now.strftime("%Y/%m/%d")

      fill_in 'purchase_address', with: 'Test address'
      fill_in 'purchase_apartment', with: 'Test apartment'

      choose("#{delivery_payment_types[0].value}")
      choose("#{delivery_payment_cost_types[0].value}")

      click_on I18n.t('save')
      expect(current_path).to eq purchases_path
      expect(page).to have_content(I18n.t('purchase.created'))
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

  def prepare_new_purchase
    delivery_payment_cost_types
    delivery_payment_types
    cities
    groups
  end
end
