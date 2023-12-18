class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :profile_picture, default: 'pfp-funny.jpeg', null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
