module V1
  module Dashboard
    class PostsController < ::V1::Dashboard::BaseController
      before_action :load_post, only: [:show, :update, :destroy]

      def show
        render json: DetailPostSerializer.new(@post).serializable_hash
      end

      def create
        post = current_user.posts.build(permitted_params)

        if post.save
          render json: DetailPostSerializer.new(post).serializable_hash
        else
          render_errors(post.errors)
        end
      end

      def update
        @post.assign_attributes(permitted_params)

        if @post.save
          render json: DetailPostSerializer.new(@post).serializable_hash
        else
          render_errors(@post.errors)
        end
      end

      def destroy
        if @post.destroy
          render json: DetailPostSerializer.new(@post).serializable_hash
        else
          render_errors(@post.errors)
        end
      end

      private

      def load_post
        @post ||= current_user.posts.find(params[:id])
      end

      def permitted_params
        params.require(:data)
          .require(:attributes)
          .permit(:title, :description, :content)
      end
    end
  end
end
