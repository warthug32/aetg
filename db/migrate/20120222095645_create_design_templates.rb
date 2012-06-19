class CreateDesignTemplates < ActiveRecord::Migration
  def self.up
    create_table :design_templates do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :design_templates
  end
end
