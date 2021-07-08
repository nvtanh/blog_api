module V1
  module Dashboard
    class HomeController < ::V1::Dashboard::BaseController
      def index
        posts = current_user.posts.page(page_number).per(page_size)
          .includes(:user, :comments).filters(filter_params)

        result = PostSerializer.new(posts).serializable_hash

        meta = {
          meta: {
            record_count: posts.total_count,
            page_count: posts.total_pages
          }
        }

        render json: result.merge!(meta)
      end

      private

      def filter_params
        params.dig(:filter)&.slice(:title) || {}
      end
    end
  end
end
