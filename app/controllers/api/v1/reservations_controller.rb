class Api::V1::ReservationsController < ApplicationController
  # skip_before_action :find_reservation, only: %i[show edit update destroy]
  before_action :authorize_request

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all.includes(:motorcycle)

    if @reservations.size.positive?
      render json: @reservations, include: [:motorcycle], status: :ok
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
    @user = User.find_by(id: reservation_params.user_id)
    @reservation = Reservation.new(reservation_params)
    
    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    set_reservation
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
    set_reservation
    @reservation.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = @user.reservations.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:city, :date, :user_id, :motorcycle_id)
  end
end
