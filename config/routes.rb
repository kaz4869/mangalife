  Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :likes, only: [:create, :destroy]
    post 'likes2' => 'likes2#create', as: 'likes2'
    delete 'like2' => 'likes2#destroy', as: 'like2'
    resources :comments, only: [:create]
  end
  get 'post/test' => 'posts#test'
  get 'post/new2' => 'posts#new2', as: 'new_post2'
  
  resources :users, only: [:show] do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get 'user/:id/post' => 'users#post', as: 'user_post'
  get 'user/:id/like_post' => 'users#like_post', as: 'user_like_post'
  get 'user/:id/favorite_post' => 'users#favorite_post', as: 'user_favorite_post'

  resources :books, only: [:index, :new]
  get 'books/search' => 'books#search'
  get 'books/create' => 'books#create'

  get '/post/hashtag/:name', to: "posts#hashtag"

  root 'hello#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
