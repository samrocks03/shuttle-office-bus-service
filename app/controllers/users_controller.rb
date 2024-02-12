class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  before_action :set_user, only: %i[show update destroy]


  load_and_authorize_resource :except => %i[login create]
  # check for except: :create, :login

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /login
  def login
    @user = User.find_by!(email: login_params[:email])

    if @user.authenticate(login_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {
        user: UserSerializer.new(@user),
        token: token,
      }, status: :accepted
    else
      render json: {
        error: "Invalid password"
      }, status: :unauthorized
    end
  end


  # POST /users
  def create
    @user = User.new(user_params)
    @token = encode_token(user_id: @user.id)
    if @user.save
      render json: {
        user: UserSerializer.new(@user),
        token: @token
      }, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: { message: "User Successfully deleted"}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number,:email, :company_id, :password)
  end

  def handle_invalid_errors(e)
    render json: {errors: e.record.errors.full_messages}
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
