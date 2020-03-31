class AddPublicToArticles < ActiveRecord::Migration[5.2]
  def change
  	add_column :articles, :public, :boolean
  end
end
