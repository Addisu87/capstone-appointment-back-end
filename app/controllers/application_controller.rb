class ApplicationController < ActionController::API
  before_action :authorized
  before_action :update_allowed_parameters, if: :devise_controller?

  def encode_token(payload)
    # should store secret in env variable
    JWT.encode(payload, 'secret')
  end

  def decoded_token
    # Authoriztion: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTIzIn0.AOXUao_6a_LbIcwkaZU574fPqvW6mPvHhwKC7Fatuws

    auth_header = request.headers['Authorization']
    return unless auth_header

    token = auth_header.chars[1]
    begin
      JWT.decode(token, 'secret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    decoded_token = decoded_token()
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
