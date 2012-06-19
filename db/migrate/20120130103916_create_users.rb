class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :hashed_password
      t.string :role
      t.text :address
      t.string :district_id
      t.string :phone
      t.boolean :status
      t.date :last_login_at
      t.string :last_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
