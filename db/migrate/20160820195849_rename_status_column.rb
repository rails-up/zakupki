class RenameStatusColumn < ActiveRecord::Migration
  def change
    rename_column :purchases, :status, :state
  end
end
