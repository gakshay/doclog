class UserRoles < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t| 
      t.integer :user_id
      t.integer :role_id
    end
  end

  def self.down
    drop_table :user_roles
  end
end
