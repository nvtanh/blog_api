require 'openssl'
require 'active_support/all'
require 'jwt'

module JwtHelper
  include ActiveSupport

  def self.generate_token(user_id:, email:)
    expiration = (Time.now + 2.months).to_i
    payload = {
      id: user_id,
      email: email,
      expiration: expiration
    }
    AuthenticationToken.encode(payload)
  end
end
