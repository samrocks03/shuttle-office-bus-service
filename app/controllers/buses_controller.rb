class BusesController < ApplicationController
  before_action :set_bus, only: %i[show update destroy]

  # GET /buses
  def index
    @buses = Bus.all
    render json: @buses.map(&method(:bus_json))
    # @buses = Bus.all
  end

  # GET /buses/1
  def show
    # render json: @bus
    render json: bus_json(@bus)
  end

  # POST /buses
  def create
    @bus = Bus.new(bus_params)

    if @bus.save
      render json: bus_json(@bus), status: :created, location: @bus
    else
      render json: @bus.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buses/1
  # PATCH/PUT
  def update
    if @bus.update(bus_params)
      render json: bus_json(@bus)
    else
      render json: @bus.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @bus.destroy
    render json: { message: 'Bus was successfully destroyed' }
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

  # Custom method to render bus JSON
  def bus_json(bus)
    {
      id: bus.id,
      number: bus.number,
      capacity: bus.capacity,
      model: bus.model,
      company_id: bus.company_id
    }
  end
end
