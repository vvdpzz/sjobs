# coding: UTF-8

class FollowedQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
end
