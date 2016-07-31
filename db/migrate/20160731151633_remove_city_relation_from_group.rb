class RemoveCityRelationFromGroup < ActiveRecord::Migration
  def change
    remove_column :groups, :city_id, :integer
  end
end
