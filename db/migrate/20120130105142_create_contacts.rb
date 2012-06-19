class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :title
      t.text :content
      t.date :publish_date
      t.string :last_updated_by
      t.string :locale
      t.boolean :activate

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
