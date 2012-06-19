class AddArticleCategoryToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :article_category_id, :integer

  end
end
