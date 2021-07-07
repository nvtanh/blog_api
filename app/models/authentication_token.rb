class AuthenticationToken
  ALGORITHM = 'HS256'.freeze

  def self.encode(params)
    payload = {
      data: {
        id: params[:id],
        email: params[:email]
      },
      exp: params[:expiration]
    }

    JWT.encode payload, secret_key, ALGORITHM
  end

  def self.decode(token)
    decoded_token = nil
    begin
      decoded_token = decode!(token)
    rescue JWT::ExpiredSignature, JWT::VerificationError
      decoded_token = nil
    end
    decoded_token
  end

  def self.expired?(token)
    expired = false
    begin
      decode!(token)
    rescue JWT::ExpiredSignature, JWT::VerificationError
      expired = true
    end
    expired
  end

  def self.decode!(token)
    JWT.decode token, secret_key, true, { algorithm: ALGORITHM }
  end

  def self.expiration_in_hours(hours)
    (Time.now + hours.hours).to_i
  end

  def self.secret_key
    Rails.application.secrets.secret_key_base
  end
end
