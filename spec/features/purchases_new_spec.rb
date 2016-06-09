require 'rails_helper'

RSpec.feature 'User visit purchase new page', :type => :feature do
  scenario 'sees ckeditor for description' do
    user = create :user, :organizer
    login_as user
    purchase = build(:purchase)

    visit new_purchase_path(purchase)

    expect(page).to have_css('#purchase_description')
  end
end