class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def register
    user = User.new(user_params)

    if user.save
      render json: { user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    return invalid_credentials unless user
    return account_locked if user.locked?
    return inactive_account unless user.active_for_authentication?

    if user.authenticate(params[:password])
      user.record_successful_login!
      render json: token_response_for(user)
    else
      user.record_failed_login!
      invalid_credentials
    end
  end

  def refresh
    refresh_token = RefreshToken.find_by(token_digest: RefreshToken.digest(params[:refresh_token]))

    return invalid_refresh_token unless refresh_token&.active?
    return inactive_account unless refresh_token.user.active_for_authentication?

    refresh_token.revoke!
    new_refresh_token = RefreshToken.generate_plain_token
    RefreshToken.create_for!(user: refresh_token.user, token: new_refresh_token, request: request)

    render json: {
      access_token: encode_access_token(refresh_token.user),
      token_type: "Bearer",
      expires_in: self.class::ACCESS_TOKEN_TTL.to_i,
      refresh_token: new_refresh_token
    }
  end

  def logout
    refresh_token = RefreshToken.find_by(token_digest: RefreshToken.digest(params[:refresh_token]))
    refresh_token&.revoke!

    head :no_content
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

  def token_response_for(user)
    refresh_token = RefreshToken.generate_plain_token
    RefreshToken.create_for!(user: user, token: refresh_token, request: request)

    {
      access_token: encode_access_token(user),
      token_type: "Bearer",
      expires_in: self.class::ACCESS_TOKEN_TTL.to_i,
      refresh_token: refresh_token,
      user: user
    }
  end

  def invalid_credentials
    render json: { error: "Invalid email or password" }, status: :unauthorized
  end

  def invalid_refresh_token
    render json: { error: "Invalid refresh token" }, status: :unauthorized
  end

  def inactive_account
    render json: { error: "Account is not active" }, status: :forbidden
  end

  def account_locked
    render json: { error: "Account is temporarily locked" }, status: :locked
  end
end
