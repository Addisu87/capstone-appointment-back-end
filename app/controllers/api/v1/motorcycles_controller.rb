class Api::V1::MotorcyclesController < ApplicationController
  # GET /motorcycles or /motorcycles.json
  before_action :authorize_request
  def index
    @motorcycles = []
    Motorcycle.all.each do |motor|
      @motorcycles.push(motor.as_json.merge({ avatar: url_for(motor.avatar) }))
    end

    if @motorcycles.size.positive?
      render json: @motorcycles
    else
      render json: { errors: 'Motorcycles not found' }, status: :not_found
    end
  end

  # GET /motorcycles/1 or /motorcycles/1.json
  def show
    @result = []
    @motorcycle = Motorcycle.find(params[:id])
    @result.push(@motorcycle.as_json.merge({ avatar: url_for(@motorcycle.avatar) }))

    render json: @result
  end

  # GET /motorcycles/new
  def new
    @motorcycle = Motorcycle.new
  end

  # GET /motorcycles/1/edit
  def edit
    set_motorcycle
  end

  # POST /motorcycles or /motorcycles.json
  def create
    @user_id = authorize_request
    if @user_id.nil?
      render json: { error: 'User token is not provided' }, status: :unauthorized
    else
      @motorcycle = Motorcycle.new(motorcycle_params)
      @motorcycle.user = @user_id
      if @motorcycle.save
        render json: @motorcycle, status: :created
      else
        render json: @motorcycle.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /motorcycles/1 or /motorcycles/1.json
  def update
    if @motorcycle.update(motorcycle_params)
      render json: @motorcycle
    else
      render json: @motorcycle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /motorcycles/1 or /motorcycles/1.json
  def destroy
    set_motorcycle
    @motorcycle.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_motorcycle
    @motorcycle = Motorcycle.find_by_id!(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def motorcycle_params
    params.require(:motorcycle).permit(:model, :duration, :description, :price, :avatar)
  end
end
