Rails.application.routes.draw do
  get 'users/show'

  devise_for :users

  root 'boards#new'
  resource :signups

  get '/' => "boards#new"
  get '/admin' => "signups#index"

  resources :boards, only: [:new, :create, :show] do
    get 'share', on: :member
  end

  resources :tasks, only: [:create, :destroy, :edit, :update, :show] do
    post 'accept', on: :member
  end

  resources :users, only: [:show]
end
