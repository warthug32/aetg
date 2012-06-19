class CreateCompanies < ActiveRecord::Migration
  
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.string :fax
      t.string :phone
      t.string :address
      t.text :description
      t.string :locale
      t.string :last_updated_by
      t.date :publish_date
      
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
