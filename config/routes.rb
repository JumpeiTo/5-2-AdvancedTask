Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search" 
  
  
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy,]
  end
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  
  resources :users, only: [:index,:show,:edit,:update] do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resource :relationships, only: [:create, :destroy]
    get "search", to: "users#search"
    get :follower, on: :member
    get :followerd, on: :member
  end
end
