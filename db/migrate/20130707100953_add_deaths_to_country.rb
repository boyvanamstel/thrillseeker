class AddDeathsToCountry < ActiveRecord::Migration
  def change
  	add_column :countries, :deaths, :integer
  end
end
