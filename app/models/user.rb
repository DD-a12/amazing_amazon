class User < ApplicationRecord
    has_many :likes, dependent: :destroy
    has_many :reviews, through: :likes
    has_many :news_articles, dependent: :destroy
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :liked_reviews, through: :likes, source: :review

    validates :email, presence: true, uniqueness: true,
    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    has_secure_password

    def full_name
        "#{first_name} #{last_name}"
    end
end
