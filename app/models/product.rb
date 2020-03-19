class Product < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    has_many :reviews, dependent: :destroy
    belongs_to :user
    before_save :capitalize_title
    after_initialize :default_price
    
    validates :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }
    validates :price, numericality: {greater_than: 0}
    validates :description, presence: true
    validates :description, length: {minimum: 10}
    
    def self.search arg
        Product.where('title ILIKE?'||'description ILIKE?',"%#{arg}%")
    end

    def tag_names
        self.tags.map{ |t| t.name }.join(", ")
    end

    def tag_names=(arg)
        self.tags = arg.strip.split(/\s*,\s*/).map do |tag_name|
            Tag.find_or_initialize_by(name: tag_name)
          end
    end

    private

    def capitalize_title
        self.title.capitalize!
    end

    def default_price
        self.price ||= 1.0
    end

    
end
