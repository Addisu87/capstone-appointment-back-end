class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode({ payload:, exp: 60.days.from_now.to_i }, 'secret')
  end

  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header
    begin
      JWT.decode(token, 'secret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end
  

  def current_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'You have to log in.' }, status: :unauthorized unless logged_in
  end
end
