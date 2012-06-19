class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :page_title
      t.string :browser_title
      t.string :page_url
      t.text :body
      t.text :link_forward
      t.integer :page_id
      t.string :locale
      t.string :banner_file_name
      t.string :banner_content_type
      t.integer :banner_file_size
      t.text :tag
      t.string :last_updated_by
      t.date :publish_date
      t.text :short_body
      t.boolean :activate
      t.boolean :isSkip
      t.boolean :show_in_menu
      t.string :design_template

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
