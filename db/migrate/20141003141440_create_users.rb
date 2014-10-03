class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.boolean :activated, default: false
      t.string :activation_token, null: false

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end