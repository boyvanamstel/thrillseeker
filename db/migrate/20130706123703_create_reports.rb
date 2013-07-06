class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.reference :country
      t.string :actueel
      t.string :terrorisme
      t.string :criminaliteit
      t.string :gebieden

      t.timestamps
    end
  end
end