class CreateDangers < ActiveRecord::Migration
  def change
    create_table :dangers do |t|
      t.references :country, index: true
      t.string :title

      t.timestamps
    end
  end
end
