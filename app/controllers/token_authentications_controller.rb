class TokenAuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create]
  def create
    @user = User.find(params[:user_id])
    @user.reset_authentication_token!
    respond_to do |format|
      format.json do
        render json: { authentication_token: @user.authentication_token }
      end
    end
  end

  def destroy
    
  end
end