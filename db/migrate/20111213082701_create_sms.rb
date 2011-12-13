class CreateSms < ActiveRecord::Migration
  def self.up
    create_table :sms do |t|
      t.integer :entity_id
      t.string :entity_type
      t.string :sender, :limit => 64
      t.string :receiver, :limit => 64
      t.string :reason, :limit => 128
      t.text :message, :limit => 1023
      t.integer :status, :limit =>  4
      t.timestamps
    end
  end

  def self.down
    drop_table :sms
  end
end
