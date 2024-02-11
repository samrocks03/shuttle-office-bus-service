class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  def index
    @reservations = Reservation.all
    render json: @reservations.map(&method(:reservation_json))
  end

  # GET /reservations/1
  def show
    render json: reservation_json(@reservation)
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      # Update the available seats count
      byebug
      @schedule = @reservation.schedule
      @schedule.update(available_seats: @schedule.available_seats - 1)
      render json: reservation_json(@reservation), status: :created, location: @reservation
    else
      render json: @reservation.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT
  def update
    if @reservation.update(reservation_params)
      render json: reservation_json(@reservation)
    else
      render json: @reservation.errors.full_messages, status: :unprocessable_entity
    end
  end


  def destroy
    @reservation.destroy
    render json: { message: 'Reservation was successfully destroyed' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:user_id, :schedule_id)
  end

  def reservation_json(reservation)
    {
      id: reservation.id,
      user_id: reservation.user_id,
      schedule_id: reservation.schedule_id,
    }
  end
end
