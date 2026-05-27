class User < ApplicationRecord
  MAX_FAILED_LOGIN_ATTEMPTS = 5
  LOCK_DURATION = 15.minutes
  EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP
  PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}\z/

  has_secure_password

  has_many :refresh_tokens, dependent: :destroy

  before_validation :normalize_email
  before_save :track_password_change, if: :will_save_change_to_password_digest?

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_FORMAT }
  validates :password, format: {
    with: PASSWORD_FORMAT,
    message: "must be at least 8 characters and include uppercase, lowercase, and number"
  }, if: -> { password.present? }
  validates :role, presence: true
  validates :status, presence: true, inclusion: { in: %w[active suspended deleted] }

  def active_for_authentication?
    status == "active"
  end

  def locked?
    locked_until.present? && locked_until.future?
  end

  def record_failed_login!
    attempts = failed_login_attempts + 1
    updates = { failed_login_attempts: attempts }
    updates[:locked_until] = LOCK_DURATION.from_now if attempts >= MAX_FAILED_LOGIN_ATTEMPTS

    update!(updates)
  end

  def record_successful_login!
    update!(failed_login_attempts: 0, locked_until: nil, last_login_at: Time.current)
  end

  def as_json(_options = {})
    {
      id: id,
      email: email,
      first_name: first_name,
      last_name: last_name,
      role: role,
      status: status,
      email_verified_at: email_verified_at,
      last_login_at: last_login_at,
      created_at: created_at,
      updated_at: updated_at
    }
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

  def track_password_change
    self.password_changed_at = Time.current
  end
end
