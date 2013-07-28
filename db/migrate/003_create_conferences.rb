class CreateConferences < ActiveRecord::Migration
  def self.up
    create_table :conferences do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :room
      t.references :category
      t.float :fee
      t.integer :currency_id
      t.integer :parent_conference_id
      t.timestamps
    end
  end

  def self.down
    drop_table :conferences
  end
end
