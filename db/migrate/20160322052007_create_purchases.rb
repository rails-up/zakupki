class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.text :description
      t.date :date
      t.string :status
      t.integer :group_id
      t.integer :owner_id
      t.integer :order_id
      t.integer :comment_id

      t.timestamps null: false
    end
  end
end
