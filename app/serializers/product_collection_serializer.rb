class ProductCollectionSerializer < ActiveModel::Serializer
  attributes :id, :description, :price, :created_at, :updated_at
end
