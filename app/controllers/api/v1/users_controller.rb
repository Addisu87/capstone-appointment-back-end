class Api::V1::UsersController < ApplicationController
  # skip_before_action :authorized, only: [:create]
  # before_action :set_user, only: %i[show update destory]
  # load_and_authorize_resource

  # GET /users or /users.json
  def index
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  # GET /users/1 or /users/1.json
  def show
    render json: @users, status: :ok
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    set_user
  end

  # POST /users or /users.json
  def create
    @user = User.new(name: params[:name], role: params[:role], password: params[:password])
    if @user.save
      @token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'Failed to create user' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    find_user
    respond_to do |format|
      if @user.update(user_params)
        format.json { render :show, status: :ok, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    find_user
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
    params.require(:user).permit(:name)
  end
end
