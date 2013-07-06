class AddWeatherToCountry < ActiveRecord::Migration
  def change
  	add_column :countries, :weather_main, :string
  	add_column :countries, :weather_temp, :string
  end
end
