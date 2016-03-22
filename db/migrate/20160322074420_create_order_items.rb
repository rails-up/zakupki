class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :name
      t.integer :quantity
      t.float :cost
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
