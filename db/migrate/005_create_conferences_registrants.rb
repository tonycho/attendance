class CreateConferencesRegistrants < ActiveRecord::Migration
  def self.up
    if !table_exists?(:conferences_registrants)
      create_table :conferences_registrants do |t|
        t.belongs_to :conference
        t.belongs_to :registrant
        t.timestamps
      end
    end
  end


  def self.down
    drop_table :conferences_registrants
  end
end
