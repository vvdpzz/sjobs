class Answer < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :question, :counter_cache => true
  
  validate :enough_credit_to_pay

  def enough_credit_to_pay
    if self.question.not_free? and self.question.correct_answer_id == 0 and self.user.credit < Settings.answer_price
      errors.add(:credit, "you do not have enough credit to pay.")
    end
  end
  
  def deduct_credit
    self.user.update_attribute(:credit, self.user.credit - Settings.answer_price)
  end
  
  def order_credit
    CreditTransaction.create(
      :user_id => self.user.id,
      :question_id => self.question.id,
      :answer_id => self.id,
      :value => Settings.answer_price,
      :trade_type => TradeType::ANSWER,
      :trade_status => TradeStatus::NORMAL
    )
  end
end
