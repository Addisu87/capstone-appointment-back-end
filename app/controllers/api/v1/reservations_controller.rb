class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations or /reservations.json
  def index
    # @reservations = Reservation.all
    @reservations = @user.reservations

    if @reservations.size.positive?
      render json: @reservations, status: :ok
    else
      render json: { errors: 'Reservations not found' }, status: :not_found
    end
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
    @reservation = Reservation.new(reservation_params.merge(user: @user))

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    set_reservation
    if @reservation.update(reservation_params)
      render json: @reservation, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    set_reservation
    @reservation.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find_by_id!(params[:id])
    # @reservation = @user.reservations.find_by_id!(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.permit(:city, :date)
  end
end
