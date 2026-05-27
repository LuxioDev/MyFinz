class CreateRefreshTokens < ActiveRecord::Migration[8.1]
  def change
    create_table :refresh_tokens, id: :string do |t|
      t.references :user, null: false, foreign_key: true, type: :string
      t.string :token_digest, null: false
      t.string :user_agent
      t.string :ip_address
      t.datetime :expires_at, null: false
      t.datetime :revoked_at
      t.datetime :last_used_at

      t.timestamps
    end

    add_index :refresh_tokens, :token_digest, unique: true
  end
end
