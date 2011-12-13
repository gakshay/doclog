class CreateMachines < ActiveRecord::Migration
  def self.up
    create_table :machines do |t|
      t.string :label, :limit => 128
      t.string :model, :limit => 128
      t.string :reg_no, :limit => 128
      t.string :type, :limit => 64
      t.string :mobile_number, :limit => 64
      t.string :ip_address, :limit => 64
      t.integer :user_id
      t.integer :current_amount
      t.string :status , :limit => 4
      t.datetime :manufacturing_date
      t.timestamps
    end
  end

  def self.down
    drop_table :machines
  end
end
