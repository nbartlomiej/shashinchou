class AddUsersToAlbums < ActiveRecord::Migration
  def self.up
    change_table :albums do |t|
      t.references :user
    end

  end

  def self.down
    remove_column :albums, :user
  end
end
