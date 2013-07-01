class CreateMembersEvents < ActiveRecord::Migration
  def self.up
    create_table :members_events do |t|
      t.belongs_to :member
      t.belongs_to :event
      t.timestamps
    end
  end

  def self.down
  end
end
