require 'acceptance_helper'

feature 'Purchase editing' do
  given(:user) { create(:user) }
  given!(:purchase) { create(:purchase, owner: user) }
  given(:edited_purchase) { build(:purchase) }
  given(:other_purchase) { create(:purchase, owner: create(:user)) }
  given!(:cities) { create_list(:city, 2) }
  given!(:groups) { create_list(:group, 2, enabled: true) }
  given!(:delivery_payment_cost_types) { create_list(:delivery_payment_cost_type, 2) }
  given!(:delivery_payment_types) { create_list(:delivery_payment_type, 2) }

  context 'Non-authenticated user' do
    scenario 'user try to edit purchase' do
      visit purchase_path(purchase)
      expect(page).to_not have_icon edit_purchase_path(purchase)
    end
  end

  context 'Authenticated user' do
    before { login_as user }

    context 'sees editing link from' do
      scenario 'show view' do
        visit purchase_path(purchase)
        expect(page).to have_icon edit_purchase_path(purchase)
      end

      scenario 'my purchases', js: true do
        visit user_profile_path
        click_on I18n.t('purchase.my_purchases')
        expect(page).to have_icon edit_purchase_path(purchase)
      end
    end

    context 'try to edit purhcase' do
      before do
        visit user_profile_path
        click_on I18n.t('purchase.my_purchases')
        find(:xpath, "//a[@href='#{edit_purchase_path(purchase)}']").click
      end

      scenario 'with invalid data' do
        fill_in 'purchase_name', with: nil
        fill_in 'purchase_description', with: nil
        fill_in 'purchase_catalogue_link', with: nil
        fill_in 'purchase_commission', with: nil
        fill_in 'purchase_end_date', with: nil
        fill_in 'purchase_address', with: nil
        fill_in 'purchase_apartment', with: nil

        click_on I18n.t('save')

        expect(current_path).to eq edit_purchase_path(purchase)
        expect(find_field('purchase_name').value).to eq purchase.name
        expect(page).to have_selector 'textarea'

        expect(page).to have_content "#{I18n.t('activerecord.attributes.purchase.name')} #{I18n.t('errors.messages.blank')}"
        expect(page).to have_content "#{I18n.t('activerecord.attributes.purchase.catalogue_link')} #{I18n.t('errors.messages.blank')}"
        expect(page).to have_content "#{I18n.t('activerecord.attributes.purchase.description')} #{I18n.t('errors.messages.blank')}"
        expect(page).to have_content "#{I18n.t('activerecord.attributes.purchase.commission')} #{I18n.t('errors.messages.blank')}"
        expect(page).to have_content "#{I18n.t('activerecord.attributes.purchase.end_date')} #{I18n.t('errors.messages.blank')}"
        expect(page).to have_content "#{I18n.t('activerecord.attributes.purchase.address')} #{I18n.t('errors.messages.blank')}"
        expect(page).to have_content "#{I18n.t('activerecord.attributes.purchase.apartment')} #{I18n.t('errors.messages.blank')}"
      end

      scenario 'with valid data' do
        fill_in 'purchase_name', with: edited_purchase.name
        fill_in 'purchase_description', with: edited_purchase.description
        find('#purchase_status').find(:xpath, 'option[2]').select_option
        select cities.last.name, from: 'purchase_city_id'
        select groups.last.name, from: 'purchase_group_id'
        fill_in 'purchase_catalogue_link', with: 'http://test.link'
        fill_in 'purchase_commission', with: 9.9
        fill_in 'purchase_end_date', with: DateTime.now.strftime("%Y/%m/%d")
        fill_in 'purchase_address', with: 'Test address'
        fill_in 'purchase_apartment', with: 'Test apartment'
        choose("#{delivery_payment_types.first.value}")
        choose("#{delivery_payment_cost_types.first.value}")

        click_on I18n.t('save')

        expect(current_path).to eq purchase_path(purchase)
        expect(page).to have_content(I18n.t('flash.purchases.update.success'))

        expect(page).to_not have_content purchase.name
        expect(page).to have_content edited_purchase.name

        expect(page).to_not have_content purchase.description
        expect(page).to have_content edited_purchase.description
      end
    end

    scenario 'try to edit other user purhcase' do
     visit purchase_path(other_purchase)
     expect(page).to_not have_icon edit_purchase_path(other_purchase)
    end
  end

  def have_icon href
    have_link(nil, href: href)
  end
end
