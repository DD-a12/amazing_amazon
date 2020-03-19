class CreateNewsArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :description
      t.timestamps
      t.string :published_at
    end
  end
end
