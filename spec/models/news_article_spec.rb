require 'rails_helper'
RSpec.describe NewsArticle, type: :model do
  describe "validates" do
    it("should require a title") do
      news_article = NewsArticle.new
      news_article.valid?
      expect(news_article.errors.messages).to(have_key(:title)) 
    end
    it("should require a unique title") do
      persisted_na = FactoryBot.create(:news_article)
      na = NewsArticle.new(title: persisted_na.title)
      na.valid? 
      expect(na.errors.messages).to(have_key(:title))
      expect(na.errors.messages[:title]).to(include('has already been taken'))
    end
  end
end
