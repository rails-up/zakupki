class AddAddressesToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :address, :string
    add_column :purchases, :apartment, :string
  end
end
