class Api::V1::ProfileController < ApplicationController
  before_action :authorize_request, except: :get_user

  def index
    render json: { success: true, data: UserSerializer.new(@current_user) }, status: :ok
  end

  def update
    updated = @current_user.update(user_params)
    if updated
      render json: { success: true, data: UserSerializer.new(@current_user), message: 'Updated' }, status: :ok
    else
      render json: { success: false, message: 'unprocessable_entity' }, status: :unprocessable_entity
    end
  end

  def get_user
    user = User.find(params[:id])
    render json: { success: true, data: UserSerializer.new(user) }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: 'User not found' }, status: :not_found
  end

  private

  def user_params
    params.permit(
      :name, :email, :password, :password_confirmation
    )
  end
end