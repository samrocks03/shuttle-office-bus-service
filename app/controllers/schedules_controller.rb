class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show update destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
    render json: @schedules
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    render json: @schedule
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render json: @schedule, status: :created, location: @schedule
    else
      render json: @schedule.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: @schedule.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    render json: { message: 'Schedule was successfully destroyed' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def schedule_params
    params.require(:schedule).permit(:start_point,:arrival_hour,:arrival_minute,:departure_hour,:departure_minute,:bus_id,:company_id)
  end
end
