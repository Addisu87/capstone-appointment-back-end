class ApplicationController < ActionController::API
  include JwtToken

  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  private

  def authenticate_user
    header = request.headers['Authorization']
    header = header.chars.last if header
    begin
      @decoded = JwtToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound && JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
