class AddMemberIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :member_id, :integer

  end
end
