require "rails_helper"

describe "User visit purchase show page" do
  it "sees purchase info" do
    purchase = create :purchase
    visit purchase_path(purchase)

    expect(page).to have_content(purchase.name)
    expect(page).to have_content(purchase.description)
    expect(page).to have_content(purchase.end_date)
    expect(page).to have_content(purchase.status)
  end

  context "when user signed in" do
    before do
      @user = create :user
      login_as @user
    end

    context "purchase that belong to user" do
      it "can delete purchase" do
        purchse = create :purchase, owner_id: @user.id

        visit purchase_path(purchse)
        click_link "delete"

        expect(page).to_not have_content(purchse.name)
      end

      it "can update purchase" do
        purchase = create :purchase, owner_id: @user.id

        visit purchase_path(purchase)
        click_link "edit"
        fill_in "purchase[description]", with: "Edited description"
        find("input[name='commit']").click

        expect(page).to have_content("Edited description")
      end
    end

    context "purchase that not belong to user" do
      it "can't delete purchse" do
        other_user = create :user
        purchse = create :purchase, owner_id: other_user.id

        visit purchase_path(purchse)

        expect(page).to_not have_link("delete")
      end

      it "can't edit purchse" do
        other_user = create :user
        purchse = create :purchase, owner_id: other_user.id

        visit purchase_path(purchse)

        expect(page).to_not have_link("edit")
      end
    end
  end

  context "when user not signed in" do
    it "can't delete purchse" do
      purchse = create :purchase

      visit purchase_path(purchse)

      expect(page).to_not have_link("delete")
    end

    it "can't edit purchse" do
      purchse = create :purchase

      visit purchase_path(purchse)

      expect(page).to_not have_link("edit")
    end
  end
end
