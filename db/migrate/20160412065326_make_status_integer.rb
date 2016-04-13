class MakeStatusInteger < ActiveRecord::Migration
  def self.up
  connection.execute(%q{
    alter table purchases
    alter column status
    type integer using cast(status as integer)})
  end

  def self.down
    change_column :purchases, :status, :string
  end
end
