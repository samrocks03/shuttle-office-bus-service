class BusesController < ApplicationController
  before_action :set_bus, only: %i[show update destroy]

  # GET /buses
  # GET /buses.json
  def index
    @buses = Bus.all
    render json: @buses
  end

  # GET /buses/1
  # GET /buses/1.json
  def show
    render json: @bus
  end

  # POST /buses
  # POST /buses.json
  def create
    @bus = Bus.new(bus_params)

    if @bus.save
      render json: @bus, status: :created, location: @bus
    else
      render json: @bus.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buses/1
  # PATCH/PUT
  def update
    if @bus.update(bus_params)
      render json: @bus
    else
      render json: @bus.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @bus.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bus
    @bus = Bus.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bus_params
    params.require(:bus).permit(:number, :capacity, :model, :company_id)
  end

end
