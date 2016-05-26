require 'rails_helper'

describe 'User visit purchase show page' do
  it 'user see comments'
  context 'unregistered' do
    it "can't leave comments" do
      purchase = create :purchase
      visit purchase_path(purchase)

      fill_in 'comment[body]', with: 'Comment1'
      click_on 'Прокомментировать'
      login_as @user
    end
  end

  context 'sign-in' do
    before do
      @user = create :user
      login_as @user
    end

    it 'can leave comments' do
      purchase = create :purchase, owner_id: @user.id
      visit purchase_path(purchase)
      fill_in 'comment[body]', with: 'Comment1'
      click_on 'Прокомментировать'
      visit purchase_path(purchase)
      expect(page).to have_content('Comment1')
    end
  end
end
