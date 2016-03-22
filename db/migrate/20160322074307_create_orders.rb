class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :status
      t.integer :purchase_id
      t.integer :orderitem_id

      t.timestamps null: false
    end
  end
end
