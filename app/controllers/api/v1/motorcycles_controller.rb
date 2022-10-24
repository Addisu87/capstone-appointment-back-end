class Api::V1::MotorcyclesController < ApplicationController
  before_action :set_motorcycle, only: %i[show edit update destroy]

  # GET /motorcycles or /motorcycles.json
  def index
    # @motorcycles = @user.motorcycles.all
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
    @motorcycle = Motorcycle.new(motorcycle_params.merge(user: @user))

    if @motorcycle.save
      render json: @motorcycle, status: :created, location: @motorcycle
    else
      render json: @motorcycle.errors, status: :unprocessable_entity
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
    @motorcycle = @user.motorcycles.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def motorcycle_params
    params.permit(:model, :duration, :description, :price, :avatar)
    # params.require(:motorcycle).permit(:model, :duration, :description, :price, :avatar)
  end
end
