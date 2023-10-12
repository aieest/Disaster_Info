Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts do
    resources :comments, except: :show
  end

  resources :categories, except: :show

  namespace :user do
    resources :posts, only: :index
    resources :comments, only: :index
  end
end
