# coding: UTF-8

class VotesController < ApplicationController
  before_filter :who_called_vote
  
  # TODO
  # fix 200 max
  def up
    vote_status = $redis.hget("#{@instance_type}:#{@instance.id}:votes", current_user.id).to_i
    same_vote = vote_status != 1
    
    if current_user.credit > Settings.vote_up_limit and current_user.vote_per_day > 0 and same_vote
      if vote_status == -1
        @instance.update_attribute(:votes_count, @instance.votes_count + 1)
        @instance.user.update_attribute(:credit, @instance.user.credit + Settings.vote_down)
        current_user.update_attribute(:credit, current_user.credit + Settings.answer_voter_down) if @instance_type == "answer"
        current_user.update_attribute(:vote_per_day, current_user.vote_per_day + 1)
      end
      $redis.hset("#{@instance_type}:#{@instance.id}:votes", current_user.id, 1)
      @instance.update_attribute(:votes_count, @instance.votes_count + 1)
      
      case @instance_type
      when "question"
        @instance.user.update_attribute(:credit, @instance.user.credit + Settings.question_vote_up)
      when "answer"
        @instance.user.update_attribute(:credit, @instance.user.credit + Settings.answer_vote_up)
      end
      
      current_user.update_attribute(:vote_per_day, current_user.vote_per_day - 1)
      
      case @instance_type
      when "question"
        record = Vote.where(:user_id => current_user.id, :question_id => @instance.id).first
        if record
          record.update_attribute(:value, 1)
        else
          Vote.create(:user_id => current_user.id, :question_id => @instance.id, :value => 1)
        end
      when "answer"
        record = Vote.where(:user_id => current_user.id, :answer_id => @instance.id).first
        if record
          record.update_attribute(:value, 1)
        else
          Vote.create(:user_id => current_user.id, :answer_id => @instance.id, :value => 1)
        end
      end
    end
  end
  
  def down
    vote_status = $redis.hget("#{@instance_type}:#{@instance.id}:votes", current_user.id).to_i
    same_vote = vote_status != -1
    if current_user.credit > Settings.vote_down_limit and current_user.vote_per_day > 0 and same_vote
      if vote_status == 1
        @instance.update_attribute(:votes_count, @instance.votes_count - 1)
        case @instance_type
        when "question"
          @instance.user.update_attribute(:credit, @instance.user.credit - Settings.question_vote_up)
        when "answer"
          @instance.user.update_attribute(:credit, @instance.user.credit - Settings.answer_vote_up)
        end
        current_user.update_attribute(:vote_per_day, current_user.vote_per_day + 1)
      end
      $redis.hset("#{@instance_type}:#{@instance.id}:votes", current_user.id, -1)
      @instance.update_attribute(:votes_count, @instance.votes_count - 1)
      @instance.user.update_attribute(:credit, @instance.user.credit - Settings.vote_down)
      current_user.update_attribute(:credit, current_user.credit - Settings.answer_voter_down) if @instance_type == "answer"
      current_user.update_attribute(:vote_per_day, current_user.vote_per_day - 1)
      
      case @instance_type
      when "question"
        record = Vote.where(:user_id => current_user.id, :question_id => @instance.id).first
        if record
          record.update_attribute(:value, -1)
        else
          Vote.create(:user_id => current_user.id, :question_id => @instance.id, :value => -1)
        end
      when "answer"
        record = Vote.where(:user_id => current_user.id, :answer_id => @instance.id).first
        if record
          record.update_attribute(:value, -1)
        else
          Vote.create(:user_id => current_user.id, :answer_id => @instance.id, :value => -1)
        end
      end
    end
  end
  
  protected
    def who_called_vote
      params.each do |name, value|
        if name =~ /(.+)_id$/
          @instance = $1.classify.constantize.find(value)
          @instance_type = $1
        end
      end
    end
end
