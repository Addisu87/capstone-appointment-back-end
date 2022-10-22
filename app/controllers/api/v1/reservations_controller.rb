class Api::V1::ReservationsController < ApplicationController
  skip_before_action :find_reservation, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /reservations or /reservations.json
  def index
    @reservations = current_user.reservations.includes(:motorcycle)

    if @reservations.size.positive?
      render json: @reservations, include: [:motorcycle], status: :ok
    else
      render json: { errors: 'Reservations not found' }, status: :not_found
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
    find_reservation
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
    find_reservation
  end

  # POST /reservations or /reservations.json
  def create
    find_reservation
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id

    respond_to do |format|
      if @reservation.save
        format.json { render :show, status: :created, location: @reservation }
      else
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    find_reservation
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    find_reservation
    @reservation.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:city, :date)
  end
end
