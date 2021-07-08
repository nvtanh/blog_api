class ApplicationController < ActionController::API
  include ErrorHandlers
  include PaginationParams

  private

  def authentication_token
    request.headers[:authentication]
  end
end
