module V1
  module Auth
    class RegistrationController < ApplicationController
      def create
        user = User.new(permitted_params)
        if user.save
          render json: UserSerializer.new(user).serializable_hash, status: :created
        else
          render_errors user.errors
        end
      end

      private

      def permitted_params
        params
          .require(:data)
          .require(:attributes)
          .permit(:email, :password, :password_confirmation)
      end
    end
  end
end
