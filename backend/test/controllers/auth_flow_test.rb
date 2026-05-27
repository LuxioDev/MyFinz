require "test_helper"

class AuthFlowTest < ActionDispatch::IntegrationTest
  setup do
    @password = "Password1"
    @user = User.create!(
      email: "user@example.com",
      password: @password,
      password_confirmation: @password,
      first_name: "Test"
    )
  end

  test "user can register with email and password" do
    assert_difference("User.count", 1) do
      post auth_register_path, params: {
        email: "NewUser@Example.COM",
        password: "Register1",
        password_confirmation: "Register1",
        first_name: "New"
      }
    end

    assert_response :created
    body = response.parsed_body
    user = User.find_by!(email: "newuser@example.com")

    assert_equal user.id, body.dig("user", "id")
    assert_nil body.dig("user", "password_digest")
    assert_not_equal "Register1", user.password_digest
  end

  test "register rejects duplicate email" do
    assert_no_difference("User.count") do
      post auth_register_path, params: {
        email: "USER@example.com",
        password: "Password1",
        password_confirmation: "Password1"
      }
    end

    assert_response :unprocessable_entity
  end

  test "register rejects invalid email and weak password" do
    assert_no_difference("User.count") do
      post auth_register_path, params: {
        email: "not-an-email",
        password: "weak",
        password_confirmation: "weak"
      }
    end

    assert_response :unprocessable_entity
  end

  test "registered user can login with valid credentials" do
    assert_difference("RefreshToken.count", 1) do
      post auth_login_path, params: { email: "USER@example.com", password: @password }
    end

    assert_response :success
    body = response.parsed_body
    refresh_token = RefreshToken.last

    assert body["access_token"].present?
    assert body["refresh_token"].present?
    assert_equal "Bearer", body["token_type"]
    assert_equal @user.id, body.dig("user", "id")
    assert_nil body.dig("user", "password_digest")
    assert_equal RefreshToken.digest(body["refresh_token"]), refresh_token.token_digest
    assert_not_equal body["refresh_token"], refresh_token.token_digest
    assert_not_nil @user.reload.last_login_at
  end

  test "login fails with invalid credentials and tracks attempts" do
    post auth_login_path, params: { email: @user.email, password: "wrong-password" }

    assert_response :unauthorized
    assert_equal 1, @user.reload.failed_login_attempts
  end

  test "login locks user after too many failed attempts" do
    User::MAX_FAILED_LOGIN_ATTEMPTS.times do
      post auth_login_path, params: { email: @user.email, password: "wrong-password" }
    end

    assert @user.reload.locked?

    post auth_login_path, params: { email: @user.email, password: @password }

    assert_response :locked
  end

  test "login fails for suspended or deleted accounts" do
    @user.update!(status: "suspended")

    post auth_login_path, params: { email: @user.email, password: @password }

    assert_response :forbidden

    @user.update!(status: "deleted")

    post auth_login_path, params: { email: @user.email, password: @password }

    assert_response :forbidden
  end

  test "valid refresh token rotates refresh token and returns new access token" do
    login_body = login!
    old_token = RefreshToken.find_by!(token_digest: RefreshToken.digest(login_body["refresh_token"]))

    assert_difference("RefreshToken.count", 1) do
      post auth_refresh_path, params: { refresh_token: login_body["refresh_token"] }
    end

    assert_response :success
    body = response.parsed_body

    assert body["access_token"].present?
    assert body["refresh_token"].present?
    assert_not_equal login_body["refresh_token"], body["refresh_token"]
    assert_not_nil old_token.reload.revoked_at
  end

  test "revoked refresh token cannot be used" do
    login_body = login!

    delete auth_logout_path, params: { refresh_token: login_body["refresh_token"] }

    assert_response :no_content

    post auth_refresh_path, params: { refresh_token: login_body["refresh_token"] }

    assert_response :unauthorized
  end

  test "me returns authenticated user without sensitive fields" do
    login_body = login!

    get me_path, headers: { "Authorization" => "Bearer #{login_body["access_token"]}" }

    assert_response :success
    body = response.parsed_body

    assert_equal @user.id, body.dig("user", "id")
    assert_equal @user.email, body.dig("user", "email")
    assert_nil body.dig("user", "password_digest")
  end

  test "me rejects missing access token" do
    get me_path

    assert_response :unauthorized
  end

  private

  def login!
    post auth_login_path, params: { email: @user.email, password: @password }
    assert_response :success
    response.parsed_body
  end
end
