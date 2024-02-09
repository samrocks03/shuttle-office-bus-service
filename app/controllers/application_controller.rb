class ApplicationController < ActionController::API
  before_action :authorized

  private

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials[:secret_key_base])
    # JWT.encode(payload,'123')

    # This method takes a payload and returns a JWT token.
    # The payload is a hash that contains the user's id.
    #  The JWT token is generated using the JWT.encode method,
    #  which takes the payload and the secret key base as arguments.
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(" ").last
      begin
        # byebug
        JWT.decode(token,  Rails.application.credentials[:secret_key_base])
        # JWT.decode(token,'123')

      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    # if the token is decoded, it'll find the user by user_id
    # It will provide the user, which is currently logged in
    p decoded_token
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
      # byebug
    end
  end

  def authorized
    unless !!current_user
    render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
