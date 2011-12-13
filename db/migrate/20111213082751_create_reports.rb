class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.integer :entity_id
      t.string :entity_type
      t.string :mobile_number, :limit => 64
      t.string :name, :limit => 128
      t.string :email
      t.text :message
      t.integer :status, :limit => 6
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
