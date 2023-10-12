class Api::V1::PostsController < ApplicationController
  before_action :authorize_request, except: [:index, :show]
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def render_unprocessable_entity_response(invalid)
    render json: { success: false, errors: invalid.record.errors.full_messages, message: 'Unprocessable entity' }, status: :unprocessable_entity
  end

  def index
    posts = Post.paginate(page: params[:page], per_page: 10)
    render json: { success: true, data: ActiveModel::Serializer::CollectionSerializer.new(posts, serializer: PostSerializer), meta: pagination_dict(posts) }, status: :ok
  end

  def show
    post = Post.find(params[:id])
    render json: { success: true, data: PostSerializer.new(post) }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: 'Post not found' }, status: :not_found
  end

  def create
    post = Post.create!(posts_params.merge(user: @current_user))
    render json: { success: true, data: PostSerializer.new(post) }, status: :created
  end

  def update
    post = Post.find_by(id: params[:id], user_id: @current_user.id)
    if post
      post.update!(posts_params)
      render json: { success: true, data: PostSerializer.new(post) }, status: :ok
    else
      render json: { success: false, message: "Post Not Found" }, status: :not_found
    end
  end

  def delete
    post = Post.find_by(id: params[:id], user_id: @current_user.id)
    if post
      post.destroy
      render json: { success: true, message: 'Deleted' }, status: :ok
    else
      render json: { success: false, message: "Post Not Found" }, status: :not_found
    end
  end

  private

  def posts_params
    params.permit(:title, :content)
  end


end
