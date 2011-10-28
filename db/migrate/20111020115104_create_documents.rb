class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.integer :user_id
      t.integer :transaction_id
      t.string :doc_file_name
      t.string :doc_content_type
      t.integer :doc_file_size
      t.datetime :doc_updated_at
      t.integer :sms_count
      t.string :direct_url
      t.timestamps
    end
    add_index :documents, :user_id
    add_index :documents, :transaction_id
  end

  def self.down
    remove_index :documents, :user_id 
    remove_index :documents, :transaction_id 
    drop_table :documents
  end
end
