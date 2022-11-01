class Api::V1::ReservationsController < ApplicationController
<<<<<<< HEAD
  # skip_before_action :find_reservation, only: %i[show edit update destroy]
=======
  before_action :set_reservation, only: %i[show update destroy]
>>>>>>> 0859e27b108f7c8ae8c1e43ba731a483dcd9be54
  before_action :authorize_request

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all

    if @reservations.size.positive?
      render json: @reservations, status: :ok
    else
      render json: { errors: 'Reservations not found' }, status: :not_found
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
    render json: @reservation, status: :ok
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
    render json: @reservation, status: :ok
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = @current_user

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    if @reservation.update(reservation_params)
      render json: @reservation, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find_by_id!(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Reservation not found' }, status: :unauthorized
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
<<<<<<< HEAD
    params.require(:reservation).permit(:city, :date, :user_id, :motorcycle_id)
=======
    params.require(:reservation).permit(:city, :date, :motorcycle_id)
>>>>>>> 0859e27b108f7c8ae8c1e43ba731a483dcd9be54
  end
end
