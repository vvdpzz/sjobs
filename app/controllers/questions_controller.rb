# coding: UTF-8

class QuestionsController < ApplicationController
  set_tab :questions
  
  set_tab :paid,  :segment, :only => %w(index)
  set_tab :free,  :segment, :only => %w(free)
  set_tab :watch, :segment, :only => %w(watch)

  def index
    @questions = Question.paid.page(params[:page]).per(1)

    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @questions }
    end
  end
  
  
  def free
    @questions = Question.free.page(params[:page]).per(Settings.questions_per_page)
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.page(params[:page]).per(Settings.answers_per_page)

    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @question }
    end
  end

  def new
    @question = Question.new

    respond_to do |format|
      format.html
      format.json { render :json => @question }
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def create
    @question = current_user.questions.build(params[:question])

    respond_to do |format|
      if @question.save
        @question.credit_rewarded? and @question.deduct_credit and @question.order_credit
        @question.money_rewarded? and @question.deduct_money and @question.order_money
        format.html { redirect_to @question, :notice => 'Question was successfully created.' }
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @question = current_user.questions.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, :notice => 'Question was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :ok }
    end
  end
  
  def follow
    question = Question.find params[:id]
    status = true
    if question
      records = FollowedQuestion.where(:user_id => current_user.id, :question_id => question.id)
      if records.empty?
        current_user.followed_questions.create(:question_id => question.id)
      else
        record = records.first
        status = record.status if record.update_attribute(:status, !record.status)
      end
      render :json => {:status => status}
    end
  end
  
  def favorite
    question = Question.find params[:id]
    status = true
    if question
      records = FavoriteQuestion.where(:user_id => current_user.id, :question_id => question.id)
      if records.empty?
        current_user.favorite_questions.create(:question_id => question.id)
      else
        record = records.first
        status = record.status if record.update_attribute(:status, !record.status)
      end
      render :json => {:status => status}
    end
  end
  
  def watch
    l = "list:#{current_user.id}:watched"
    items = $redis.lrange(l, 0, -1)
    @list = items.collect{ |item| $redis.lrange(item, 0, -1) }
  end
end
