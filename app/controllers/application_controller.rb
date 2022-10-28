class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode({ payload:, exp: 60.days.from_now.to_i }, 'secret')
  end

<<<<<<< HEAD
  def decoded_token
    auth_header = request.headers['Authorization']
    return unless auth_header

    token = auth_header.chars[1]
    begin
      JWT.decode(token, 'secret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
=======
  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = JWT.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
>>>>>>> eb0d81f4bb36605ebbf10d17b1f0c1207e6613d8
    end
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

<<<<<<< HEAD
    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end
=======
  # def current_user
  #   return unless decoded_token
  #   user_id = decoded_token[0]['user_id']
  #   @user = User.find_by(id: user_id)
  # end
>>>>>>> eb0d81f4bb36605ebbf10d17b1f0c1207e6613d8

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'You have to log in.' }, status: :unauthorized unless logged_in
  end
end
