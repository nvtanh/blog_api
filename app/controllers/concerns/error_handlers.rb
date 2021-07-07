module ErrorHandlers
  extend ActiveSupport::Concern
  included do
    [
      BlogApiBasicError,
    ].each do |klass|
      rescue_from klass do |exception|
        render_errors(exception.message, exception.http_status)
      end
    end
  end

  def render_errors(errors, status = :unprocessable_entity)
    render json: { errors: errors }, status: status
  end
end
