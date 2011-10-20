class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.integer :user_id
      t.string :doc_file_name
      t.string :doc_content_type
      t.integer :doc_file_size
      t.datetime :doc_updated_at
      t.integer :sms_count
      t.string :direct_url
      t.timestamps
    end
    add_index :documents, :user_id
  end

  def self.down
    drop_table :documents
  end
end
