class NewsArticle < ApplicationRecord
    belongs_to :user
    validates :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }
    validates :description, presence: true
end
