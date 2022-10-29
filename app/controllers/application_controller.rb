class ApplicationController < ActionController::API
  def encode_token(payload)
    # should store secret in env variable
    JWT.encode({ payload:, exp: 60.days.from_now.to_i }, 'secret')
  end

  def authorize_request
    # { 'Authorization': 'Bearer <token>' }
    header = request.headers['Authorization']
    header = header.split.last if header
    # headers: { 'Authorization': 'Bearer <token>' }
    begin
      @decoded = JWT.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
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
