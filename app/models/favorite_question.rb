# coding: UTF-8

class FavoriteQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
end
