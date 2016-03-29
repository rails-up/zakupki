class AddEnabledToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :enabled, :boolean, default: false
  end
end
