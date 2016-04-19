require 'rails_helper'

describe "User visit grops index page" do
  it "there more then 10 groups" do
    create_list :group, 11, :enabled

    visit groups_path

    expect(page).to have_selector('.pagination')
  end

  it "there less then 10 groups" do
    create_list :group, 9, :enabled

    visit groups_path

    expect(page).to_not have_selector('.pagination')
  end
end
