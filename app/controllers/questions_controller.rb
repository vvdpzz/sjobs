class QuestionsController < ApplicationController

  def index
    @questions = Question.paid.page(params[:page]).per(1)

    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @questions }
    end
  end
  
  def free
    @questions = Question.free.page(params[:page]).per(1)
  end

  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html
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
  
  def watch
    question = Question.find params[:id]
    status = true
    if question
      records = WatchedQuestion.where(:user_id => current_user.id, :question_id => question.id)
      if records.empty?
        current_user.watched_questions.create(:question_id => question.id)
      else
        record = records.first
        status = record.status if record.update_attribute(:status, !record.status)
      end
      render :json => {:status => status}
    end
  end
end
