require "rails_helper"

describe "User visit purchase show page" do
  it "sees purchase info" do
    purchase = create :purchase
    visit purchase_path(purchase)

    expect(page).to have_content(purchase.name)
    expect(page).to have_content(purchase.description)
    expect(page).to have_content(I18n.l(purchase.end_date, format: :long))
    expect(page).to have_content(purchase.status)
    expect(page).to have_content(purchase.city.name)
    expect(page).to have_content(purchase.owner.username)
    expect(page).to have_content(purchase.group.name)
    expect(page).to have_content(purchase.catalogue_link)
    expect(page).to have_content(purchase.delivery_payment_type.value)
    expect(page).to have_content(purchase.delivery_payment_cost_type.value)
    expect(page).to have_content(purchase.address)
    expect(page).to have_content(purchase.apartment)
    expect(page).to have_content(purchase.commission)
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
