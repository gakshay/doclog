class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :machine_id
      t.integer :user_id
      t.string :mobile_number, :limit => 64
      t.integer :amount
      t.string :type, :limit => 64
      t.integer :status, :limit => 4  
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
