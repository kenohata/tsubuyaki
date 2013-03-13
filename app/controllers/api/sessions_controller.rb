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
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        head :no_content
      end
    end
  end
end