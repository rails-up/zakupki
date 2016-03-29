class RemoveColumnsFromPurchases < ActiveRecord::Migration
  def change
    remove_column :purchases, :comment_id, :integer
    remove_column :purchases, :order_id, :integer
    rename_column :purchases, :date, :end_date
  end
end
