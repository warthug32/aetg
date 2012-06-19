class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :first_name
      t.string :middle_initial
      t.string :last_name
      t.string :position
      t.string :page_url
      t.text :brief_intro
      t.text :body
      t.string :phone_direct
      t.string :mobile_no
      t.string :email
      t.string :cover_file_name
      t.string :cover_content_type
      t.integer :cover_file_size
      t.string :locale
      t.string :last_updated_by
      t.date :publish_date
      t.boolean :activate
      t.integer :display_order
      
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
