class RefreshToken < ApplicationRecord
  TOKEN_TTL = 30.days

  belongs_to :user

  validates :token_digest, presence: true, uniqueness: true
  validates :expires_at, presence: true

  scope :active, -> { where(revoked_at: nil).where("expires_at > ?", Time.current) }

  def self.generate_plain_token
    SecureRandom.urlsafe_base64(64)
  end

  def self.digest(token)
    OpenSSL::Digest::SHA256.hexdigest(token.to_s)
  end

  def self.create_for!(user:, token:, request:)
    create!(
      user: user,
      token_digest: digest(token),
      user_agent: request.user_agent,
      ip_address: request.remote_ip,
      expires_at: TOKEN_TTL.from_now
    )
  end

  def active?
    revoked_at.nil? && expires_at.future?
  end

  def revoke!
    update!(revoked_at: Time.current)
  end

  def touch_last_used!
    update!(last_used_at: Time.current)
  end
end
