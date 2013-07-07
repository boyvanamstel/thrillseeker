class CreateConsulates < ActiveRecord::Migration
  def change
    create_table :consulates do |t|
      t.references :country, index: true
      t.string :title
      t.string :location
      t.string :url
      t.string :mail
      t.string :telephone
      t.string :fulladdress
      t.string :contact

      t.timestamps
    end
  end
end
