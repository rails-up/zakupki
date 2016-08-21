require 'rails_helper'

feature 'Commenting groups' do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  scenario "Non-authenticated user can't leave comments" do
    group
    visit group_path(group)

    fill_in 'comment[body]', with: 'Comment1'
    click_on 'Прокомментировать'
    login_as @user
  end

  scenario 'Authenticated user can leave comments' do
    group
    login_as user
    visit group_path(group)

    fill_in 'comment[body]', with: 'Comment1'
    click_on 'Прокомментировать'
    visit group_path(group)
    expect(page).to have_content('Comment1')
  end
end
