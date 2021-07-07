class ApplicationController < ActionController::API
  private

  def render_errors(errors, status = :unprocessable_entity)
    render json: { errors: errors }, status: status
  end
end
