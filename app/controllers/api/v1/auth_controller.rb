class Api::V1::AuthController < ApplicationController
  #before_action :authorize_request, except: %i[signIn,signUp]

  def sign_in
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { success: true, token: token, expired: time.strftime("%m-%d-%Y %H:%M"),
                     user: UserSerializer.new(@user) }, status: :ok
    else
      render json: { success: false, message: 'E-mail or password is wrong' }, status: :unauthorized
    end
  end

  def sign_up
    @user = User.new(user_params)
    if @user.save

      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i

      render json: { success: true, data: { token: token, expired: time.strftime("%m-%d-%Y %H:%M"), user: UserSerializer.new(@user) }, }, status: :ok
    else
      render json: { success: false, errors: @user.errors.full_messages, message: 'Unprocessable entity' },
             status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.permit(
      :name, :email, :password, :password_confirmation
    )
  end

end