class Review < ApplicationRecord
  has_many :votings, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liker, through: :likes, source: :user
  has_many :votes, through: :votings
  belongs_to :product
  belongs_to :user
  validates :rating, numericality: 
            {greater_than_or_equal_to: 1, less_than_or_equal_to: 5},
            presence: true
  
  def throw_vote
    self.votes.map{ |t| t.up_or_down }
  end

  def throw_vote=(arg)
    Vote.find_or_initialize_by(up_or_down: arg)
  end
end
