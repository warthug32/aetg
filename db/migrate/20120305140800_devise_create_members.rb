class DeviseCreateMembers < ActiveRecord::Migration
  def self.up
    create_table(:members) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      
      t.string :title
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :job_title
      t.string :department
      t.text :self_introduction
      t.string :organization_name
      
      t.string :title_zh
      t.string :first_name_zh
      t.string :last_name_zh
      t.text :address_zh
      t.string :job_title_zh
      t.string :department_zh
      t.text :self_introduction_zh
      t.string :organization_name_zh
      
      t.string :title_gb
      t.string :first_name_gb
      t.string :last_name_gb
      t.text :address_gb
      t.string :job_title_gb
      t.string :department_gb
      t.text :self_introduction_gb
      t.string :organization_name_gb
      
      t.integer :industry_id
      t.integer :educategory_id
      t.integer :nature_id
      
      t.string :telephone
      t.text :website
      
      t.timestamps
    end

    add_index :members, :email,                :unique => true
    add_index :members, :reset_password_token, :unique => true
    add_index :members, :confirmation_token,   :unique => true
    # add_index :members, :unlock_token,         :unique => true
    # add_index :members, :authentication_token, :unique => true
  end

  def self.down
    drop_table :members
  end
end
