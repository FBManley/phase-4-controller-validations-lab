class PostsController < ApplicationController
  # handle all ActiveRecord::RecordInvalid exceptions in the whole controller with rescue_from method
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def show
    post = Post.find(params[:id])
    render json: post
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    render json: post, status: :ok
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  # def render_unprocessable_entity(invalid)
  #   render json:{error: invalid.record, status: :unprocessable_entity}
  # end
end

