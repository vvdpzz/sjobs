class NewAnswer
  @queue = :new_answer

  def self.perform(question_id, answer_id)
    question = Question.find question_id
    answer   = Answer.find answer_id
    
    question_hash = {
      :json_type => "Question",
      :id        => question_id,
      :title     => question.title
    }
    answer_hash = {
      :json_type => "Answer",
      :id        => answer_id,
      :content   => answer.content,
      :user_id   => answer.user.id,
      :username  => answer.user.username,
      :about_me  => answer.user.about_me
    }
    question.watched_user_ids.each do |user_id|
      l = "list:#{user_id}:watched"
      
      e = Redis.back l

      if e
        c, i = e.split(":")
        i = i.to_i
        if i != question_id
          e = "#{incr c}:#{question_id}"
          Redis.push_back l, e
          Redis.push_back e, MultiJson.encode(question_hash)
        end
        Redis.push_back e, MultiJson.encode(answer_hash)
      else
        e = "0:#{question_id}"
        Redis.push_back l, e
        Redis.push_back e, MultiJson.encode(question_hash)
        Redis.push_back e, MultiJson.encode(answer_hash)
      end
    end
  end
end