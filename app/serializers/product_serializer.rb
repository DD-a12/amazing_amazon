class ProductSerializer < ActiveModel::Serializer
  attributes :id, :description, :price, :created_at, :updated_at
  belongs_to :user, key: :seller
  has_many :reviews

  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :rating
  end

end
