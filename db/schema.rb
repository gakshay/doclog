# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111213082751) do

  create_table "documents", :force => true do |t|
    t.integer  "user_id"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.integer  "sms_count"
    t.string   "direct_url"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "machines", :force => true do |t|
    t.string   "label",              :limit => 128
    t.string   "model",              :limit => 128
    t.string   "reg_no",             :limit => 128
    t.string   "type",               :limit => 64
    t.string   "mobile_number",      :limit => 64
    t.string   "ip_address",         :limit => 64
    t.integer  "user_id"
    t.integer  "current_amount"
    t.string   "status",             :limit => 4
    t.datetime "manufacturing_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "machine_id"
    t.integer  "user_id"
    t.string   "mobile_number", :limit => 64
    t.integer  "amount"
    t.string   "type",          :limit => 64
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.string   "mobile_number", :limit => 64
    t.string   "name",          :limit => 128
    t.string   "email"
    t.text     "message"
    t.integer  "status",        :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "CreateRoles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sms", :force => true do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.string   "sender",      :limit => 64
    t.string   "receiver",    :limit => 64
    t.string   "reason",      :limit => 128
    t.text     "message"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "document_id"
    t.string   "document_secret"
    t.integer  "sender_id"
    t.string   "sender_mobile",   :limit => 64
    t.integer  "receiver_id"
    t.string   "receiver_mobile", :limit => 64
    t.string   "receiver_email"
    t.boolean  "sms_sent",                      :default => false
    t.integer  "sms_count"
    t.string   "type",            :limit => 64
    t.integer  "status"
    t.datetime "sms_sent_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["receiver_email"], :name => "index_transactions_on_receiver_email"
  add_index "transactions", ["receiver_mobile"], :name => "index_transactions_on_receiver_mobile"
  add_index "transactions", ["sender_mobile"], :name => "index_transactions_on_sender_mobile"

  create_table "user_roles", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             :limit => 64
    t.string   "middle_name",            :limit => 64
    t.string   "last_name",              :limit => 64
    t.string   "mobile",                 :limit => 64
    t.integer  "age"
    t.string   "gender",                 :limit => 10
    t.text     "address"
    t.string   "city",                   :limit => 64
    t.string   "state",                  :limit => 64
    t.string   "pincode",                :limit => 10
    t.integer  "status"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["mobile"], :name => "index_users_on_mobile"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "watchdogs", :force => true do |t|
    t.string   "type",       :limit => 64
    t.string   "severity",   :limit => 64
    t.string   "referrer"
    t.string   "location"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
