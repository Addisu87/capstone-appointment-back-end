class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destory]
  # GET /users or /users.json
  def index
    @users = User.all
    render json: UserSerializer.new(@users)
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: @user, token:, status: :created
    else
      render json: { error: 'Invalid name or password' }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(name: user_params[:name])
    if @user&.authenticate(user_params[:password])
      time = Time.now + 24.hours.to_i
      token = JWT.encode({ user_id: @user.id, exp: 24.hours.to_i }, 'my_s3cr3t')
      render json: { username: @user.name, token:, exp: time.strftime('%m-%d-%Y %H:%M') }, status: :ok
    else
      render json: { error: 'Invalid name or password' }, status: :unauthorized
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    set_user
    if @user.update(user_params)
      render json: @user, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    set_user
    @user.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:name, :password)
    # params.require(:user).permit(:name, :password)
  end
end
