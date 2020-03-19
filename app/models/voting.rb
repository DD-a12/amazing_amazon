class Voting < ApplicationRecord
    belongs_to :review
    belongs_to :vote
end
