class Api::SessionsController < Devise::SessionsController
  skip_before_filter :protect_from_forgery

  def create
    build_resource
    resource = User.find_for_database_authentication(email: params[:api_user][:email])
    render json: { error: 'cant find such a user.' } unless resource

    if resource.valid_password?(params[:api_user][:password])
      resource.ensure_authentication_token!
      render json: {
        auth_token: resource.authentication_token,
        user: resource
         },
        status: :created
    else
      render json: {error: 'invalid username or password.'}
    end
  end

  def destroy
    begin
      @user = User.find_by_authentication_token(params[:auth_token])
      @user.reset_authentication_token!
      render json: { messages: ['reset token'] }
    rescue
      render json: { errors: ['invalid auth token'] }
    end
  end
end