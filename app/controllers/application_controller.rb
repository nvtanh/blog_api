class ApplicationController < ActionController::API
  include ErrorHandlers

  private

  def authentication_token
    request.headers[:authentication]
  end
end
