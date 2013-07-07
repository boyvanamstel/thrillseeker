class ReportStringsToText < ActiveRecord::Migration
  def change
  	change_column :reports, :algemeen, :text, :limit => nil
  	change_column :reports, :actueel, :text, :limit => nil
  	change_column :reports, :terrorisme, :text, :limit => nil
  	change_column :reports, :criminaliteit, :text, :limit => nil
  	change_column :reports, :gebieden, :text, :limit => nil
  end
end
