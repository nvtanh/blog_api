module AuthClient
  extend ActiveSupport::Concern

  def authenticate
    return render_errors("Token is required", :unauthorized) if authentication_token.blank?
    decode_token = AuthenticationToken.decode(authentication_token)
    if decode_token.present?
      @current_user = User.find(decode_token.first["data"]["id"])
    else
      render_errors("Token is invalid", :forbidden)
    end
  end

  def current_user
    @current_user
  end
end
