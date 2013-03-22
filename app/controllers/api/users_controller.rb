class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def follow
    @user = User.find(params[:user_id])
    @follow = current_user.follows.build followed_user: @user

    if @follow.save
      render json: { message: 'success' }
    else
      render json: { message: 'failed'  }
    end
  end

  def unfollow
    @follow = current_user.follows.find_by_followed_id(params[:user_id])
    @follow.destroy

    render json: { message: 'success' }
  end
end