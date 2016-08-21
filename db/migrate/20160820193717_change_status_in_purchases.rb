class ChangeStatusInPurchases < ActiveRecord::Migration
  def change
    change_column :purchases, :status, :string
  end
end
