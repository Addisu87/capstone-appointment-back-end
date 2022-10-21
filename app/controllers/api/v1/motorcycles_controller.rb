class Api::V1::MotorcyclesController < ApplicationController
  before_action :set_motorcycle, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /motorcycles or /motorcycles.json
  def index
    @motorcycles = Motorcycle.where(user_id: current_user.id).order(created_at: :desc)
  end

  # GET /motorcycles/1 or /motorcycles/1.json
  def show
    set_motorcycle
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
    @motorcycle = Motorcycle.new(motorcycle_params)
    @motorcycle.user_id = current_user.id

    respond_to do |format|
      if @motorcycle.save
        format.html { redirect_to api_v1_motorcycles_url(@motorcycle), notice: 'Motorcycle was successfully created.' }
        format.json { render :show, status: :created, location: @motorcycle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @motorcycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /motorcycles/1 or /motorcycles/1.json
  def update
    set_motorcycle
    respond_to do |format|
      if @motorcycle.update(motorcycle_params)
        format.html { redirect_to api_v1_motorcycle_url(@motorcycle), notice: 'Motorcycle was successfully updated.' }
        format.json { render :show, status: :ok, location: @motorcycle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @motorcycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motorcycles/1 or /motorcycles/1.json
  def destroy
    @motorcycle.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_motorcycle_url, notice: 'Motorcycle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_motorcycle
    @motorcycle = Motorcycle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def motorcycle_params
    params.require(:motorcycle).permit(:model, :duration, :description, :price)
  end
end
