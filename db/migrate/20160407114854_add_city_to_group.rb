class AddCityToGroup < ActiveRecord::Migration
  def change
    add_reference :groups, :city, index: true, foreign_key: true
  end
end
