require 'rails_helper'

describe 'User visit group show page' do
  it 'user see comments'
  context 'unregistered' do
    it "can't leave comments" do
      group = create :group
      visit group_path(group)
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
      group = create :group
      visit group_path(group)
      fill_in 'comment[body]', with: 'Comment1'
      click_on 'Прокомментировать'
      visit group_path(group)
      expect(page).to have_content('Comment1')
    end
  end
end
