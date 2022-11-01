class Api::V1::ReservationsController < ApplicationController
  # skip_before_action :find_reservation, only: %i[show edit update destroy]
  before_action :authorize_request

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all.includes(:motorcycle)
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
    @user = User.find(reservation_params[:user_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      p 'Reservation saved'
      render json: @reservation, status: :created
    else
      p 'Failed to save Reservation'
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
    # @reservation = @user.reservations.find_by_id!(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Reservation not found' }, status: :unauthorized
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:city, :date, :user_id, :motorcycle_id)
  end
end
