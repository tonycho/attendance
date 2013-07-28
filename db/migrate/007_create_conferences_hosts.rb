class CreateConferencesHosts < ActiveRecord::Migration
  def self.up
    if !table_exists?(:conferences_hosts)
      create_table :conferences_hosts do |t|
        t.belongs_to :conference
        t.belongs_to :host
        t.timestamps
      end
    end
  end

  def self.down
    drop_table :conferences_hosts
  end
end
