class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.string :name
      t.integer :media_type_id
      t.integer :conference_id
      t.string :location
      t.timestamps
    end
  end

  def self.down
    drop_table :media
  end
end
