# coding: UTF-8

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answer
end
