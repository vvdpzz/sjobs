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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20110908092925) do
=======
ActiveRecord::Schema.define(:version => 20110909081450) do
>>>>>>> a712ae6a7e6385765445a2d8b94394fe330eed04

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

<<<<<<< HEAD
=======
  create_table "favorite_questions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.boolean  "status",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_questions", ["question_id"], :name => "index_favorite_questions_on_question_id"
  add_index "favorite_questions", ["user_id"], :name => "index_favorite_questions_on_user_id"

  create_table "followed_questions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.boolean  "status",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followed_questions", ["question_id"], :name => "index_followed_questions_on_question_id"
  add_index "followed_questions", ["user_id"], :name => "index_followed_questions_on_user_id"

>>>>>>> a712ae6a7e6385765445a2d8b94394fe330eed04
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
    t.string   "encrypted_password",     :limit => 128,                               :default => ""
    t.string   "about_me",                                                            :default => ""
    t.integer  "questions_count",                                                     :default => 0
    t.integer  "answers_count",                                                       :default => 0
    t.integer  "votes_count",                                                         :default => 0
    t.integer  "vote_per_day",                                                        :default => 40
    t.integer  "credit_today",                                                        :default => 0
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
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["answer_id"], :name => "index_votes_on_answer_id"
  add_index "votes", ["question_id"], :name => "index_votes_on_question_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

  create_table "watched_questions", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "question_id",                   :null => false
    t.boolean  "status",      :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "watched_questions", ["question_id"], :name => "index_watched_questions_on_question_id"
  add_index "watched_questions", ["user_id"], :name => "index_watched_questions_on_user_id"

end
