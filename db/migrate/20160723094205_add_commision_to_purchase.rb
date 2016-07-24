class AddCommisionToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :commission, :float
  end
end
