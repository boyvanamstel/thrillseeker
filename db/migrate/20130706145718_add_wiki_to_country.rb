class AddWikiToCountry < ActiveRecord::Migration
  def change
  	add_column :countries, :wiki, :string
  	add_column :countries, :price, :integer
  end
end
