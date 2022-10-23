class Api::V1::AuthController < ApplicationController
  # skip_before_action :authorized, only: [:create], raise: false

  def login
    @user = User.find_by(name: login_params[:name])
    # User#authenticate comes from BCrypt
    if @user&.authenticate(login_params[:password])
      # encode token comes from ApplicationController
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
    else
      render json: { message: 'Invalid username' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:user).permit(:name, :password)
  end
end
