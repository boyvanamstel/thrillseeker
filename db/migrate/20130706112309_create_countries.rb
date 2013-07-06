class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :openid
      t.string :title
      t.string :classification

      t.timestamps
    end
  end
end
