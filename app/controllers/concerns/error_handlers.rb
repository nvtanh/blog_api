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

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  def render_errors(errors, status = :unprocessable_entity)
    render json: { errors: errors }, status: status
  end

  def record_not_found
    render_errors("record not found", :not_found)
  end

end
