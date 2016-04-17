require 'rails_helper'
include FormHelpers

describe 'Joining and leaving a group' do
  let!(:user) { create(:user) }
  let!(:group) { create(:group) }

  before(:each) do
    sign_in(user.email, '11111111')
    visit(group_path(group))
  end

  it "sees join group button" do
    expect(page).to have_content(I18n.t('group.join'))
  end

  it "does not see leave group button" do
    expect(page).not_to have_content(I18n.t('group.leave'))
  end

  it "button text changes after user presses join the group" do
    click_link(I18n.t('group.join'))
    expect(page).to have_content(I18n.t('group.leave'))
  end

  it "button text changes after user presses leave the group" do
    click_link(I18n.t('group.join'))
    click_link(I18n.t('group.leave'))
    expect(page).to have_content(I18n.t('group.join'))
  end
end

