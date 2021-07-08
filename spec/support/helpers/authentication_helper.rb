module AuthenticationHelper
  def user_header(user_id:, email:)
    {
      'Accept' => 'application/json',
      'Authentication' => JwtHelper.generate_token(user_id: user_id, email: email)
    }
  end

  def anonymous_header
    {
      'Accept' => 'application/json'
    }
  end
end
