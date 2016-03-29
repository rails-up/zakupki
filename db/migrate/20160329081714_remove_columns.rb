class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :users, :group_id, :integer
    remove_column :users, :purchase_id, :integer
    remove_column :users, :order_id, :integer
    remove_column :users, :comment_id, :integer
    remove_column :users, :follower_id, :integer
    remove_column :users, :followed_id, :integer
    remove_column :orders, :orderitem_id, :integer
  end
end
