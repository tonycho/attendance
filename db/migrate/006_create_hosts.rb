class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string :title
      t.text :description
      t.string :firstname
      t.string :middleabbr
      t.string :lastname
      t.string :phone
      t.string :mobile
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :hosts
  end
end
