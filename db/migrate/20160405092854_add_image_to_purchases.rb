class AddImageToPurchases < ActiveRecord::Migration
  def change
    add_attachment :purchases, :image  
  end
end
