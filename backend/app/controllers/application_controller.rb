class ApplicationController < ActionController::API
  ACCESS_TOKEN_TTL = 15.minutes

  before_action :authenticate_user!

  attr_reader :current_user

  private

  def authenticate_user!
    payload = decode_access_token
    @current_user = User.find_by(id: payload["sub"])

    return if @current_user&.active_for_authentication?

    render json: { error: "Unauthorized" }, status: :unauthorized
  rescue JWT::DecodeError, JWT::ExpiredSignature
    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def encode_access_token(user)
    JWT.encode(
      {
        sub: user.id,
        exp: ACCESS_TOKEN_TTL.from_now.to_i,
        iat: Time.current.to_i
      },
      jwt_secret,
      "HS256"
    )
  end

  def decode_access_token
    token = request.authorization.to_s.split.last
    raise JWT::DecodeError, "Missing token" if token.blank?

    JWT.decode(token, jwt_secret, true, { algorithm: "HS256" }).first
  end

  def jwt_secret
    Rails.application.secret_key_base
  end
end
