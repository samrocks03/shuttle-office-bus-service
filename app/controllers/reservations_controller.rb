class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  load_and_authorize_resource
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
    @schedule = @reservation.schedule

    # Check if there are available seats on the bus
    if @schedule.available_seats > 0
      if @reservation.save
        # Update the available seats count
        @schedule.decrement_available_seat
        render json: reservation_json(@reservation), status: :created, location: @reservation
      else
        render json: @reservation.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: { message: 'Cannot make reservation, no seats available!' }, status: :unprocessable_entity
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
