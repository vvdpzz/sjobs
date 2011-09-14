# coding: UTF-8

class AnswersController < ApplicationController
  def create
    question = Question.find params[:question_id]
    @answer = current_user.answers.build(params[:answer])

    respond_to do |format|
      if @answer.save
        question.not_free? and question.correct_answer_id == 0 and @answer.deduct_credit and @answer.order_credit
        question.async_new_answer(@answer.id)
        format.html { redirect_to question, :notice => 'Answer was successfully created.' }
        format.json { render :json => @answer, :status => :created, :location => [question, @answer] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end
end
