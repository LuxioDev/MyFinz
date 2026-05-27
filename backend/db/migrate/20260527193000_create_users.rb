class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users, id: :string do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.string :role, null: false, default: "user"
      t.string :status, null: false, default: "active"
      t.datetime :email_verified_at
      t.datetime :last_login_at
      t.datetime :password_changed_at
      t.integer :failed_login_attempts, null: false, default: 0
      t.datetime :locked_until

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
