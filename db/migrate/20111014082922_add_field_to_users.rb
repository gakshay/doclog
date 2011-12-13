class AddFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :limit => 64
    add_column :users, :middle_name, :string, :limit => 64
    add_column :users, :last_name, :string, :limit => 64
    add_column :users, :mobile, :string, :limit => 64
    add_column :users, :age, :integer
    add_column :users, :gender, :string, :limit => 10 
    add_column :users, :address, :text, :limit => 500 
    add_column :users, :city, :string, :limit => 64 
    add_column :users, :state, :string, :limit => 64 
    add_column :users, :pincode, :string, :limit => 10 
    add_column :users, :status, :integer, :limit => 4
    add_index :users, :mobile
  end

  def self.down
    remove_index :users, :mobile
    remove_column :users, :first_name
    remove_column :users, :middle_name
    remove_column :users, :last_name
    remove_column :users, :mobile
    remove_column :users, :age
    remove_column :users, :gender
    remove_column :users, :address
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :pincode
    remove_column :users, :status
  end
end
