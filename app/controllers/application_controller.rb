class ApplicationController < ActionController::API
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

  def encode_token(payload)
    JWT.encode({ payload:, exp: 60.days.from_now.to_i }, 'secret')
  end

  def decoded_token
    auth_header = request.headers['Authorization']
    return unless auth_header

    token = auth_header.chars[1]
    begin
      JWT.decode(token, 'secret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def authorized_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def authorize
    render json: { message: 'You have to log in.' }, status: :unauthorized unless authorized_user
  end
end
