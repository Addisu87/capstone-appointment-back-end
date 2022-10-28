class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode({ payload:, exp: 60.days.from_now.to_i }, 'secret')
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = JWT.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
  end

  # def decoded_token
  #   auth_header = request.headers['Authorization']
  #   return unless auth_header
  #   begin
  #     @decoded = JsonWebToken.decode(header)
  #     @current_user = User.find(@decoded[:user_id])
  #   rescue ActiveRecord::RecordNotFound => e
  #     render json: { errors: e.message }, status: :unauthorized
  #   rescue JWT::DecodeError => e
  #     render json: { errors: e.message }, status: :unauthorized
  #   end
  # end

  # def current_user
  #   return unless decoded_token
  #   user_id = decoded_token[0]['user_id']
  #   @user = User.find_by(id: user_id)
  # end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'You have to log in.' }, status: :unauthorized unless logged_in
  end
end
