require 'acceptance_helper'

describe 'login user visit profile page' do
  let(:user) { create :user }
  before do
    login_as user
  end

  it 'sees profile info ' do
    visit root_path
    click_link I18n.t('nav.profile')

    expect(page).to have_content user.name
    expect(page).to have_selector "img[src$='#{user.gravatar}']"
  end

  it 'can edit his profile info' do
    visit user_profile_path
    click_link I18n.t('edit')

    fill_in 'user[username]', with: 'New user name'
    find("input[name='commit']").click

    expect(page).to have_content 'New user name'
  end

  it 'sees his purchases list', js: true do
    #pending 'not yet done'
    purchase = create :purchase
    user.purchases << purchase

    visit user_profile_path
    click_link I18n.t('purchase.my_purchases')

    expect(page).to have_content(purchase.name)
  end

  it 'sees groups he joined', js: true do
    group_user_join = create(:group)
    user.groups << group_user_join

    visit user_profile_path
    click_link I18n.t('group.my_groups')

    expect(page).to have_content(group_user_join.name)
  end

  it 'sees his subscribes', js: true do
    visit user_profile_path
    click_link I18n.t('profile.my_subscriptions')

    expect(page).to have_content(I18n.t('profile.my_subscriptions'))
  end

  it 'sees his common', js: true do
    visit user_profile_path
    click_link I18n.t('profile.common')
    
    expect(page).to have_content(I18n.t('profile.common'))
  end

  it 'user see purchase profile' do
  
      purchase = create :purchase
      visit user_profile_path
      click_link I18n.t('purchase.my_purchases')
      expect(page).to have_content(I18n.t('purchase.my_purchases'))
  end

  it 'can change his password', target: true do
    new_password = '12345678'
    visit user_profile_path

    click_link I18n.t('profile.change_password')

    fill_in I18n.t('activerecord.attributes.user.current_password'),
            with: user.password
    fill_in I18n.t('activerecord.attributes.user.password'),
            with: new_password
    fill_in I18n.t('activerecord.attributes.user.password_confirmation'),
            with: new_password
    click_on I18n.t('profile.change_password')
    click_on I18n.t('nav.log_out')
    expect(login_as(@user)).to be_truthy
  end
end
