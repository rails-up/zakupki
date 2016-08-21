require 'acceptance_helper'

feature 'Change purchase status' do
  let(:user) { create(:user, :organizer) }
  let(:purchase) { create(:purchase, owner: user) }
  let(:closed_purchase) { create(:closed_purchase, owner: user) }

  context 'User try to update' do
    before do
      login_as user
    end

    scenario 'first state' do
      purchase
      visit user_profile_path

      click_on I18n.t('purchase.change_status')

      within('#change_purchase') do
        click_link I18n.t('save')
      end

      within('.current_state') do
        expect(page).to have_content I18n.t('activerecord.state_machines.purchase.states.funding')
      end
    end

    scenario 'last state', js: true do
      closed_purchase
      visit user_profile_path
      click_on I18n.t('purchase.my_purchases')

      expect(page).to_not have_link I18n.t('purchase.change_status')
    end
  end
end
