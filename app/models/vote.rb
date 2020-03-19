class Vote < ApplicationRecord
    has_many :votings, dependent: :destroy
    has_many :reviews, through: :votings
end
