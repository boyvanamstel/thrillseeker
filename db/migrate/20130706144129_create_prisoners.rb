class CreatePrisoners < ActiveRecord::Migration
  def change
    create_table :prisoners do |t|
      t.references :country, index: true
      t.integer :count

      t.timestamps
    end
  end
end
