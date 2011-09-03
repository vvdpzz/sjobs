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

ActiveRecord::Schema.define(:version => 20110831095124) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.integer  "question_id",                    :null => false
    t.text     "content",                        :null => false
    t.boolean  "is_correct",  :default => false
    t.integer  "votes_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "credit_transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "winner_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.boolean  "payment",      :default => true
    t.integer  "value"
    t.integer  "trade_type"
    t.integer  "trade_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_transactions", ["answer_id"], :name => "index_credit_transactions_on_answer_id"
  add_index "credit_transactions", ["question_id"], :name => "index_credit_transactions_on_question_id"
  add_index "credit_transactions", ["user_id"], :name => "index_credit_transactions_on_user_id"
  add_index "credit_transactions", ["winner_id"], :name => "index_credit_transactions_on_winner_id"

  create_table "money_transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "winner_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.decimal  "value",        :precision => 8, :scale => 2
    t.boolean  "payment",                                    :default => true
    t.integer  "trade_type"
    t.integer  "trade_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "money_transactions", ["answer_id"], :name => "index_money_transactions_on_answer_id"
  add_index "money_transactions", ["question_id"], :name => "index_money_transactions_on_question_id"
  add_index "money_transactions", ["user_id"], :name => "index_money_transactions_on_user_id"
  add_index "money_transactions", ["winner_id"], :name => "index_money_transactions_on_winner_id"

  create_table "questions", :force => true do |t|
    t.integer  "user_id",                                                          :null => false
    t.string   "title",                                                            :null => false
    t.text     "content"
    t.integer  "credit",                                          :default => 0
    t.decimal  "money",             :precision => 8, :scale => 2, :default => 0.0
    t.integer  "answers_count",                                   :default => 0
    t.integer  "votes_count",                                     :default => 0
    t.integer  "correct_answer_id",                               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "realname"
    t.string   "username",                                                                             :null => false
    t.string   "email",                                                               :default => "",  :null => false
    t.string   "encrypted_password",     :limit => 128,                               :default => "",  :null => false
    t.string   "about_me",                                                            :default => ""
    t.integer  "questions_count",                                                     :default => 0
    t.integer  "answers_count",                                                       :default => 0
    t.integer  "votes_count",                                                         :default => 0
    t.integer  "gpa",                                                                 :default => 0
    t.integer  "credit",                                                              :default => 0
    t.decimal  "money",                                 :precision => 8, :scale => 2, :default => 0.0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end