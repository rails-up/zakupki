class ChangeDefaultCommissionValue < ActiveRecord::Migration
  def change
    change_column :purchases, :commission, :float, default: 0
  end
end
