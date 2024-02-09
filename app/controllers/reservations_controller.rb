class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    render json: @reservation
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:user_id, :schedule_id, :date)
  end
end
