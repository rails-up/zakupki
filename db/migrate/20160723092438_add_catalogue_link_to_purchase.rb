class AddCatalogueLinkToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :catalogue_link, :string
  end
end
