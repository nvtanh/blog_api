module V1
  class SessionsService
    def create_session(user)
      token_expiration = AuthenticationToken.expiration_in_hours(2)

      authentication_token = AuthenticationToken.encode(
        id: user.id,
        email: user.email,
        expiration: token_expiration
      )

      authentication_token
    end

    def authenticate(email, password)
      user = User.find_by(email: email)
      if user.blank? || !user.valid_password?(password)
        raise BlogApiBasicError.new('email or password invalid!', 422)
      end

      user
    end

    def validate_session_token(session_token)
      return false if session_token.nil?
      decoded_token = AuthenticationToken.decode(session_token)
      decoded_token.nil? ? false : decoded_token.first['data']
    end

    def destroy_session(session)
      return false if session.nil?

      true
    end
  end
end
