class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @questions = @user.questions.page(params[:page]).per(5)
  end
  
  def follow
    user = User.find params[:id]
    if user and user.id != current_user.id
      # if not in Redis add relationship
      if not user.has_relationship_redis(current_user.id)
        user.followers.create(:follower_id => current_user.id)
        $redis.sadd("users:#{current_user.id}.follows", params[:id])
        # maybe not in Redis but in DB, add relationship also add in Redis
      elsif not user.has_relationship_db(current_user.id)
        user.followers.create(:follower_id => current_user.id)
        $redis.sadd("users:#{current_user.id}.follows", params[:id])
      end
      current_user.async_follow_user(user.id) if user.has_relationship_redis(current_user.id)
      render :json => {:status => true}
    else
      render :json => {:error => true}, :status => :unprocessable_entity
    end
  end
  
  def unfollow
    following_user = User.find params[:id]
    if following_user
      if following_user.has_relationship_redis(current_user.id)
        following_user.followers.update_arributes(:status => false)
        $redis.serm("user:#{current_user.id}.follows", params[:id])
      elsif following_user.has_relationship_db(current_user.id)
        following_user.update_by_sql(params[:id],current_user.id)
      end
    end
  end
end
