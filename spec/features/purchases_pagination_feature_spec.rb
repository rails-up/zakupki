require 'rails_helper'

describe "User visit purchases index page" do
  it "when there more then 10 purchases" do
    create_list :opened_purchase, 11

    visit purchases_path

    expect(page).to have_selector('.pagination')
  end

  it "when there less then 8 purchases" do
    create_list :opened_purchase, 2

    visit purchases_path

    expect(page).to_not have_selector('.pagination')
  end
end
