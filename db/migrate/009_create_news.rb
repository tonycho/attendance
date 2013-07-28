class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer :conference_id
      t.string :title
      t.text :note
      t.boolean :notification
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
