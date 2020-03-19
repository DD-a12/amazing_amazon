# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new 
      alias_action :create, :read, :update, :destroy, to: :crud
      can :crud, Product do |product|
      product.user == user
      end
      
      can :crud, Review do |review|
        review.user == user || review.product.user == user
      end

      can :crud, NewsArticle do |news_article|
        news_article.user == user
      end

      can :like, Review do |review|
        user.persisted? && review.user != user
      end

      if user.is_admin?
        can :manage, :all
      end
  end
end
