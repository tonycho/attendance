class CreateMediaTypes < ActiveRecord::Migration
  def self.up
    create_table :media_types do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    MediaType.reset_column_information
    %w{Image Video Other}.each do |type|
      MediaType.create(:name => type)
    end
  end

  def self.down
    drop_table :media_types
  end
end
