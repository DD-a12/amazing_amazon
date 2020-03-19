Rails.application.routes.draw do
  
  root 'welcome#index'
  
  get 'about' , to: 'welcome#about', as: 'about'
  get 'contact' ,to: 'welcome#contact', as: 'contact'
  get 'edit/password/:id/', to: 'users#edit_password', as: 'edit_password'
  patch 'edit/password/:id/', to: 'users#update_password'
  patch 'products/:product_id/reviews/:id', to: 'reviews#hidden', as: 'hidden_review'
  get  'admin/panel', to: 'users#admin_panel' 
  
  resources :products
  
  resources :users, only: [:create, :new, :edit , :update]
  
  resource :session, only: [:create, :new , :destroy]
  
  resources :products do
    resources :reviews, only: [:create, :destroy, :edit, :update]
  end
  
  resources :reviews do 
    resources :likes, shallow: true, only: [:create, :destroy]
    resources :votings, only: [:create, :update, :destroy]
    get :liked, on: :collection
  end
  
  resources :news_articles
  
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      resources :products
      resource :session, only: [:create]
    end
  end
end
