class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :body_type
      t.string :gender
      t.date :dob
      t.string :password
      t.string :email

      t.timestamps null: false
    end
  end
end
