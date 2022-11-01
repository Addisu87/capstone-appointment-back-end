class Api::V1::SessionsController < ApplicationController
  # POST /api/v1/login
  def create
    @user = User.find_by(name: session_params[:name])

    # @user.authenticate('password')
    if @user&.authenticate(session_params[:password])
      @token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user).serializable_hash.to_json
        , jwt: @token }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def show
    if logged_in?
      render json: current_user
    else
      render json: { error: 'Please log in' }
    end
  end

  private

  def session_params
    params.permit(:name, :password)
    # params.require(:user).permit(:name, :password)
  end
end
