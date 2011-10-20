class CreateTransactions < ActiveRecord::Migration
  def self.up
   create_table :transactions do |t|
    t.integer :document_id
    t.string :document_secret
    t.integer :sender_id
    t.string :sender_mobile, :limit => 64
    t.integer :receiver_id
    t.string :receiver_mobile, :limit => 64
    t.string :receiver_email
    t.boolean :sms_sent, :default => false
    t.integer :sms_count
    t.datetime :sms_sent_time
    t.timestamps
   end
   add_index :transactions, :sender_mobile
   add_index :transactions, :receiver_mobile
   add_index :transactions, :receiver_email 
  end

  def self.down
    remove_index :transactions, :sender_mobile
    remove_index :transactions, :receiver_mobile
    remove_index :transactions, :receiver_email
    drop_table :transactions
  end
end
