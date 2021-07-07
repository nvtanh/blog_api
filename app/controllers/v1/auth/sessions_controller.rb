class V1::Auth::SessionsController < ApplicationController
  def create
    user = sessions_service.authenticate(permitted_params[:email], permitted_params[:password])

    render json: { token: sessions_service.create_session(user) }, status: :ok
  end

  def destroy
    session = sessions_service.validate_session_token(authentication_token)
    status = session ? 'success' : 'unauthorized'
    result = { data: { attributes: { status: status } } }

    render json: result
  end

  private

  def sessions_service
    V1::SessionsService.new
  end

  def permitted_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:email, :password)
  end
end
