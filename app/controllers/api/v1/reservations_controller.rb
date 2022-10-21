class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.where(user_id: current_user.id).order(created_at: :desc)
  end

  # GET /reservations/1 or /reservations/1.json
  def show
    set_reservation
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
    set_reservation
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id

    respond_to do |format|
      if @reservation.save
        format.html do
          redirect_to api_v1_reservations_url(@reservation), notice: 'Reservation was successfully created.'
        end
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    set_reservation
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html do
          redirect_to api_v1_reservation_url(@reservation), notice: 'Reservation was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    set_reservation
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_reservation_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:city, :date)
  end
end
