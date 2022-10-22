class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user!

  # POST /auth/login
  def login
    @user = User.find_by_id!(params[:id])
    if @user&.authenticate(params[:name])
      token = JwtToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'), name: @user.name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
