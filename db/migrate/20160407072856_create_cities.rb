class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
    end

    add_reference :purchases, :city, index: true, foreign_key: true
  end
end
