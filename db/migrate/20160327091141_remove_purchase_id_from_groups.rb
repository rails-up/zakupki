class RemovePurchaseIdFromGroups < ActiveRecord::Migration
  def change
    remove_columns :groups, :purchase_id
  end
end
