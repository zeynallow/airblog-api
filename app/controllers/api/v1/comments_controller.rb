class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request, except: [:get_comments]

  def get_comments
    comments = Comment.where(post_id: params[:id])
    render json: { success: true, data: ActiveModel::Serializer::CollectionSerializer.new(comments, serializer: CommentSerializer) }, status: :ok
  end

  def create
    post = Post.find(params[:id])
    comment = Comment.create!(comment_params.merge(user: @current_user, post: post))
    render json: { success: true, data: CommentSerializer.new(comment) }, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: 'Post not found' }, status: :not_found

  end

  def update
    comment = Comment.find_by(id: params[:id], user_id: @current_user.id)
    if comment
      comment.update!(comment_params)
      render json: { success: true, data: CommentSerializer.new(comment) }, status: :ok
    else
      render json: { success: false, message: "Comment Not Found" }, status: :not_found
    end
  end

  def delete
    comment = Comment.find_by(id: params[:id], user_id: @current_user.id)
    if comment
      comment.destroy
      render json: { success: true, message: 'Deleted' }, status: :ok
    else
      render json: { success: false, message: "Comment Not Found" }, status: :not_found
    end
  end

  private

  def comment_params
    params.permit(:comment)
  end

end
