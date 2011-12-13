class CreateWatchdogs < ActiveRecord::Migration
  def self.up
    create_table :watchdogs do |t|
      t.string :type, :limit => 64
      t.string :severity, :limit => 64
      t.string :referrer
      t.string :location
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :watchdogs
  end
end
