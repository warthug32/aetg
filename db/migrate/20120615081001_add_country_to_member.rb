class AddCountryToMember < ActiveRecord::Migration
  def change
    add_column :members, :country, :text
  end
end
