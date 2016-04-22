require "rails_helper"

describe "User visit purchase index page" do
  it "sees all purchases" do
    purchases = create_list :purchase, 3

    visit purchases_path

    purchases.each do |purchase|
      purchase_content(purchase)
    end
  end

  it "can view purchase details when click on it" do
    purchase = create :purchase

    visit purchases_path

    find(".activator", match: :first).click

    expect(page).to have_content(purchase.name)
    expect(page).to have_content(purchase.description)
    expect(page).to have_content(purchase.end_date)
  end

  context "when user signed in"  do
    it "can create new purchase" do
      user = create :user, :organizer
      login_as user

      visit purchases_path
      click_link I18n.t('purchase.new')
      fill_in "purchase[name]", with: "New purchase name"
      fill_in "purchase[description]", with: "Some description"
      fill_in "purchase[end_date]", with: Time.current + 5.days
      find("input[name='commit']").click

      # expect(page).to have_content("New purchase name")
      expect(page).to have_content("Some description")
    end
  end

  context "when user not signed in" do
    it "can't create new purchase" do
      visit purchases_path

      expect(page).to_not have_link(I18n.t('purchase.new'),new_purchase_path)
    end
  end
end

def purchase_content(purchase)
  expect(page).to have_css(".card-title", purchase.name)
  expect(page).to have_content(purchase.description)
end
