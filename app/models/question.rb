class Question < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :answers, :dependent => :destroy
  
  # validations
  validates_numericality_of :money, :message => "is not a number", :greater_than_or_equal_to => 0
  validates_numericality_of :credit, :message => "is not a number", :greater_than_or_equal_to => 0
  validates_presence_of :title, :message => "can't be blank"
  validate :enough_credit_to_pay
  validate :enough_money_to_pay
  
  def enough_credit_to_pay
    errors.add(:credit, "you do not have enough credit to pay.") if self.user.credit < self.credit
  end
  
  def enough_money_to_pay
    errors.add(:money, "you do not have enough money to pay.") if self.user.money < self.money
  end
  
  def not_free?
    self.credit != 0 or self.money != 0
  end
  
  ["credit", "money"].each do |name|
    define_method "#{name}_rewarded?" do
      self.send(name) > 0
    end
    
    define_method "deduct_#{name}" do
      self.user.update_attribute(name.to_sym, self.user.send(name) - self.send(name))
    end
    
    define_method "order_#{name}" do
      if self.send(name) > 0
        "#{name}_transaction".classify.constantize.create(
          :user_id => self.user.id,
          :question_id => self.id,
          :value => self.send(name),
          :trade_type => TradeType::ASK,
          :trade_status => TradeStatus::NORMAL
        )
      end
    end
  end
  
end