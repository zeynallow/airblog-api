class Api::V1::UsersController < ApplicationController
    #skip_before_action :authorized, only: [:create]
  
    def index
      users = User.all 
      render json: users 
    end
  
    def show
      user = User.find(params[:id])
      render json: user 
    end
  
    def profile
      render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end 
  
  
    private 
  
  end