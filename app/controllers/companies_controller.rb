class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  load_and_authorize_resource
  # GET /companies
  def index
    @companies = Company.all
    render json: @companies
  end

  # GET /companies/1
  def show
    render json: @company
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company, status: :created, location: @company
    else
      render json: @company.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT
  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :location)
  end

end
