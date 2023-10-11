class Api::V1::PostsController < ApplicationController
    #before_action :authorized, except: [:index]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
    
    private def render_not_found_response
      render json: { error: "Post Not Found" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def index
        render json: Post.all
    end

    def show
        render json: Post.find(params[:id])
    end

    # def create
    #     post = Post.create!(artist_params)
    #     render json: post, status: :created
    #   end
      
      
    #  private def posts_params
    #     params.permit(:title, :content, :genre)
    #   end

    # def update
    #     post = Post.find(params[:id])
    #     post.update!(posts_params)
    #     render json: post
    #   end

    # def destroy
    #     Post.find(params[:id]).destroy
    #     head :no_content
    #   end

end
