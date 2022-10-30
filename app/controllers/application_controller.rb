class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  def encode_token(payload, exp: 24.days.from_now)
    payload[:exp] = exp.to_i
    # should store secret in env variable
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    # { 'Authorization': 'Bearer <token>' }
    header = request.headers['Authorization']
    header = header.split.last if header
    # headers: { 'Authorization': 'Bearer <token>' }
    begin
      @decoded = JWT.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound || JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'You have to log in.' }, status: :unauthorized unless logged_in?
  end
end
